import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gym_guardian_membership/homepage/data/models/workout_recommendation_model.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:os_basecode/os_basecode.dart';

Future<void> printAllGeminiModels() async {
  var models = await Gemini.instance.listModels();
  for (var model in models) {
    log("Model Name : ${model.name},", name: "GEMINI");
  }
}

Future<bool> removePreviousResult() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var status = await sharedPreferences.remove('lastGeneratedResult');
  log("Removing previous result + ${status ? "Success" : "Failed"}", name: "GEMINI");
  return status;
}

Future<WorkoutRecommendationModel?> getRecommendation(
    String name,
    int age,
    String gender,
    String fitnessLevel,
    String goal,
    String duration,
    String equipment,
    String preference,
    String availability,
    String specialConditions,
    String? customPromp) async {
  try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var prefResult = sharedPreferences.getString("lastGeneratedResult");

    // **Mendeteksi Locale dari Perangkat**
    String deviceLocale = Intl.getCurrentLocale(); // Contoh: "id_ID", "en_US", "fr_FR"
    String language = deviceLocale.split('_')[0]; // Ambil kode bahasa (id, en, fr)

    String basePrompt = '''
    **Role**: Anda adalah personal trainer profesional dengan sertifikasi NASM dan 10 tahun pengalaman.

    **User Profile**:
    - Nama: $name
    - Usia: $age tahun
    - Jenis Kelamin: $gender
    - Level Aktivitas Saat Ini: $fitnessLevel
    - Tujuan Utama: $goal
    - Durasi Latihan Harian: $duration
    - Peralatan Tersedia: $equipment
    - Preferensi Latihan: $preference
    - Waktu Tersedia: $availability
    - Kondisi Khusus: $specialConditions

    **Instruksi**:
    1. Buat/MODIFIKASI program latihan 1 minggu dengan ketentuan:
      - Sesuaikan dengan profil user dan equipment yang ada
      - ${prefResult != null ? 'Pertahankan elemen yang masih relevan dari program sebelumnya' : ''}
      - Gunakan prinsip periodisasi dan FITT (Frequency, Intensity, Time, Type)
      - Sertakan pemanasan dan pendinginan di setiap sesi
      - Berikan variasi untuk mencegah kebosanan
      - Perhatikan batasan waktu dan kondisi khusus

    2. **Terjemahkan hasil latihan ke bahasa yang sesuai dengan locale pengguna**
      - Kode bahasa pengguna: $language
      - Gunakan bahasa yang sesuai, misalnya Bahasa Indonesia untuk 'id', English untuk 'en', dll.
      - Namun, pastikan **key dalam JSON tetap dalam bahasa Inggris**, hanya nilai (value) yang diterjemahkan.

    3. Constraints:
      - Waktu generasi maksimal 30 detik
      - Hanya gunakan format JSON yang valid
      - Validasi dengan prinsip fisiologi olahraga
      - Hindari latihan berisiko tinggi untuk kondisi khusus
    ''';

    // Jika ada hasil sebelumnya, tambahkan ke prompt untuk revisi
    if (prefResult != null) {
      basePrompt += '''
      
      **Current Workout Plan:**
      ${extractJson(prefResult)}
      
      Please revise the above plan based on the following feedback:
      ''';
    }

    basePrompt += '''
    
    $customPromp
    
    **Format jawaban dalam JSON (tetap dalam bahasa Inggris untuk key-nya, tetapi nilai dalam locale pengguna):**
    {
      "program_name": "string",
      "client_info": {
        "name": "string",
        "age": number,
        "gender": "string",
        "fitness_level": "string",
        "goal": "string",
        "duration": number,
        "equipment": "string",
        "preference": "string",
        "availability": "string",
        "special_conditions": "string"
      },
      "weekly_plan": [
        {
          "day": "string",
          "workout": {
            "duration": number,
            "activity": [
              {
                "name": "string",
                "duration": number,
                "description": "string"
              }
            ]
          }
        }
      ],
      "notes": "string"
    }
    ''';

    log("Generating Gemini Response", name: "GEMINI");
    log(basePrompt, name: "GEMINI");
    final response =
        await Gemini.instance.prompt(parts: [Part.text(basePrompt)], model: 'gemini-2.0-flash-exp');
    log("Generating Finish", name: "GEMINI");
    if (response?.output == null) return null;

    final newResult = response!.output!;
    await sharedPreferences.setString("lastGeneratedResult", newResult);

    return workoutRecommendationModelFromJson(extractJson(newResult));
  } catch (e, s) {
    throw Exception(s.toString());
  }
}

Future<void> getOneWorkoutRecommendation(
    String name,
    int age,
    String gender,
    String fitnessLevel,
    String goal,
    String duration,
    String equipment,
    String preference,
    String availability,
    String specialConditions,
    String? customPromp,
    BuildContext context) async {
  try {
    // **Mendeteksi Locale dari Perangkat**
    String deviceLocale = Intl.getCurrentLocale(); // Contoh: "id_ID", "en_US", "fr_FR"
    String language = deviceLocale.split('_')[0]; // Ambil kode bahasa (id, en, fr)

    String basePrompt = '''
    **Role**: Kamu adalah personal trainer profesional dengan sertifikasi NASM dan pengalaman lebih dari 10 tahun. Saya sedang berada di gym dan ingin melakukan 1 jenis olahraga yang kamu rekomendasikan.

    **User Profile**:
    - Nama: $name
    - Usia: $age tahun
    - Jenis Kelamin: $gender
    - Level Aktivitas Saat Ini: $fitnessLevel
    - Tujuan Utama: $goal
    - Durasi Total Latihan Harian: $duration
    - Peralatan Tersedia: $equipment
    - Preferensi Latihan: $preference
    - Waktu Tersedia: $availability
    - Kondisi Khusus: $specialConditions

    **Instruksi:**
    1. Berikan **1 rekomendasi olahraga** yang paling sesuai dengan profil saya.
    2. Jelaskan alat apa yang digunakan.
    3. Berapa lama durasi total latihannya?
    4. Berapa banyak **repetisi dan set** yang harus dilakukan?
    5. Berapa lama waktu istirahat antar repetisi dan set?
    6. Apa **manfaat utama** dari latihan ini?
    7. Bagaimana **cara melakukan latihan ini dengan benar** untuk menghindari cedera?
    8. Ambil link video dari object Peralatan Tersedia dengan key tutorial_video
    9. Masukan tutorial_video ke tutorial_youtube_url
    10. Untuk reps_per_set gunakan angka pasti, misalkan 3 atau 5

    2. **Terjemahkan hasil latihan ke bahasa yang sesuai dengan locale pengguna**
    - Kode bahasa pengguna: $language
    - Gunakan bahasa yang sesuai, misalnya Bahasa Indonesia untuk 'id', English untuk 'en', dll.
    - Namun, pastikan **key dalam JSON tetap dalam bahasa Inggris**, hanya nilai (value) yang diterjemahkan.

    3. Constraints:
    - Waktu generasi maksimal 30 detik
    - Hanya gunakan format JSON yang valid
    - Validasi dengan prinsip fisiologi olahraga
    - Hindari latihan berisiko tinggi untuk kondisi khusus

    **Format jawaban Harus dalam JSON (tetap dalam bahasa Inggris untuk key-nya, tetapi nilai dalam locale pengguna):**
    {
      "exercise_name": "string",
      "equipment": "string",
      "duration": "number (menit)",
      "sets": "number",
      "reps_per_set": "number",
      "rest_between_reps": "number (detik)",
      "rest_between_sets": "number (detik)",
      "benefits": "string",
      "how_to_do": "string",
      "tutorial_youtube_url": "string",
    }
    ''';
    if (customPromp != null) {
      await addNewChat(customPromp, customPromp, "user");
    } else {
      await addNewChat(basePrompt, "Buatkan Rekomendasi Workout", "user");
    }
    context.read<ChatHistoryBloc>().add(DoLoadChatHistory());
    // Load dan batasi chat history yang dikirim ke AI (misalnya 10 terakhir)
    List<ChatHistoryModel> chatHistory = await loadChatHistory();
    List<Content> chatContents = chatHistory
        .take(20) // Ambil 20 terakhir
        .map((e) => Content(parts: [Part.text(e.prompt)], role: e.role))
        .toList();
    log("Generating Response", name: "GEMINI");
    final response = await Gemini.instance.chat(chatContents, modelName: 'gemini-2.0-flash-exp');
    log("Generating Finish", name: "GEMINI");
    if (response?.output == null) return;

    // Simpan hasil percakapan ke dalam history
    await addNewChat(
      response!.output!,
      response.output!,
      "model",
    );
    if (!context.mounted) return;

    return;
  } catch (e, s) {
    throw Exception(s.toString());
  }
}

Future<void> getChallengeWorkout(
    String name,
    int age,
    String gender,
    String fitnessLevel,
    String goal,
    String duration,
    String equipment,
    String preference,
    String availability,
    String specialConditions,
    String? customPromp,
    BuildContext context) async {
  try {
    // **Mendeteksi Locale dari Perangkat**
    String deviceLocale = Intl.getCurrentLocale(); // Contoh: "id_ID", "en_US", "fr_FR"
    String language = deviceLocale.split('_')[0]; // Ambil kode bahasa (id, en, fr)

    String basePrompt = '''
    **Role**: Kamu adalah personal trainer profesional dengan sertifikasi NASM dan pengalaman lebih dari 10 tahun. Saya sedang berada di gym dan ingin melakukan 1 jenis olahraga yang kamu rekomendasikan.

    **User Profile**:
    - Nama: $name
    - Usia: $age tahun
    - Jenis Kelamin: $gender
    - Level Aktivitas Saat Ini: $fitnessLevel
    - Tujuan Utama: $goal
    - Durasi Total Latihan Harian: $duration
    - Peralatan Tersedia: $equipment
    - Preferensi Latihan: $preference
    - Waktu Tersedia: $availability
    - Kondisi Khusus: $specialConditions

    **Instruksi:**
    1. Berikan **1 tantangan olahraga** yang paling sesuai dengan profil saya.
    2. Jelaskan alat apa yang digunakan.
    3. Berapa lama durasi total latihannya?
    4. Berapa banyak **repetisi dan set** yang harus dilakukan?
    5. Berapa lama waktu istirahat antar repetisi dan set?
    6. Apa **manfaat utama** dari latihan ini?
    7. Bagaimana **cara melakukan latihan ini dengan benar** untuk menghindari cedera?
    8. Ambil link video dari object Peralatan Tersedia dengan key tutorial_video
    9. Masukan tutorial_video ke tutorial_youtube_url
    10. Untuk reps_per_set gunakan angka pasti, misalkan 3 atau 5

    2. **Terjemahkan hasil latihan ke bahasa yang sesuai dengan locale pengguna**
    - Kode bahasa pengguna: $language
    - Gunakan bahasa yang sesuai, misalnya Bahasa Indonesia untuk 'id', English untuk 'en', dll.
    - Namun, pastikan **key dalam JSON tetap dalam bahasa Inggris**, hanya nilai (value) yang diterjemahkan.

    3. Constraints:
    - Waktu generasi maksimal 30 detik
    - Hanya gunakan format JSON yang valid
    - Validasi dengan prinsip fisiologi olahraga
    - Hindari latihan berisiko tinggi untuk kondisi khusus

    **Format jawaban Harus dalam JSON (tetap dalam bahasa Inggris untuk key-nya, tetapi nilai dalam locale pengguna):**
    {
      "exercise_name": "string",
      "equipment": "string",
      "duration": "number (menit)",
      "sets": "number",
      "reps_per_set": "number",
      "rest_between_reps": "number (detik)",
      "rest_between_sets": "number (detik)",
      "benefits": "string",
      "how_to_do": "string",
      "tutorial_youtube_url": "string",
    }
    ''';
    if (customPromp != null) {
      await addNewChat(customPromp, customPromp, "user");
    } else {
      await addNewChat(basePrompt, "Buatkan Tantangan Workout", "user");
    }
    context.read<ChatHistoryBloc>().add(DoLoadChatHistory());
    // Load dan batasi chat history yang dikirim ke AI (misalnya 10 terakhir)
    List<ChatHistoryModel> chatHistory = await loadChatHistory();
    List<Content> chatContents = chatHistory
        .take(20) // Ambil 20 terakhir
        .map((e) => Content(parts: [Part.text(e.prompt)], role: e.role))
        .toList();
    log("Generating Response", name: "GEMINI");
    final response = await Gemini.instance.chat(chatContents, modelName: 'gemini-2.0-flash-exp');
    log("Generating Finish", name: "GEMINI");
    if (response?.output == null) return;

    // Simpan hasil percakapan ke dalam history
    await addNewChat(
      response!.output!,
      response.output!,
      "model",
    );
    if (!context.mounted) return;

    return;
  } catch (e, s) {
    throw Exception(s.toString());
  }
}

Future<void> saveChatHistory(List<ChatHistoryModel> chatHistory) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(chatHistory.map((e) => e.toJson()).toList());
    await prefs.setString('chat_history', jsonString);
  } catch (e) {
    print("Error saving chat history: $e");
  }
}

Future<List<ChatHistoryModel>> loadChatHistory() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('chat_history');

    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((e) => ChatHistoryModel.fromJson(e)).toList();
    }
  } catch (e) {
    print("Error loading chat history: $e");
  }
  return [];
}

Future<void> addNewChat(
  String prompt,
  String text,
  String role,
) async {
  try {
    List<ChatHistoryModel> chatHistory = await loadChatHistory();

    // Tambahkan chat baru ke list
    chatHistory
        .add(ChatHistoryModel(role: role, text: text, prompt: prompt, timestamp: DateTime.now()));

    // Batasi hanya menyimpan 20 percakapan terakhir
    if (chatHistory.length > 20) {
      chatHistory = chatHistory.sublist(chatHistory.length - 20);
    }

    // Simpan ke SharedPreferences
    await saveChatHistory(chatHistory);
  } catch (e) {
    print("Error saving chat history: $e");
  }
}

class ChatHistoryModel {
  String text;
  String prompt;
  String role;
  DateTime timestamp;
  ChatHistoryModel(
      {required this.role, required this.text, required this.timestamp, required this.prompt});

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
        role: json['role'] ?? "user",
        text: json['text'] ?? "",
        timestamp: DateTime.now(),
        prompt: json['prompt'] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {"role": role, "text": text, "prompt": prompt, "timestamp": timestamp.toIso8601String()};
  }
}

Future<void> clearChatHistory(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('chat_history');
  if (!context.mounted) return;
  context.read<ChatHistoryBloc>().add(DoLoadChatHistory());
}

String extractJson(String input) {
  return input.replaceAll("```", "").replaceAll("json", "");
}
