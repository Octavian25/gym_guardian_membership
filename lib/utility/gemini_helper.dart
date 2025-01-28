import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gym_guardian_membership/homepage/data/models/workout_recommendation_model.dart';
import 'package:os_basecode/os_basecode.dart';

Future<WorkoutRecommendationModel?> getRecommendation(
    String name, // Nama pengguna
    int age, // Usia
    String gender, // Jenis kelamin
    String fitnessLevel, // Tingkat aktivitas saat ini
    String goal, // Tujuan utama
    int duration, // Durasi latihan per hari
    String equipment, // Peralatan yang tersedia
    String preference, // Preferensi latihan
    String availability, // Waktu yang tersedia (pagi/siang/malam)
    String specialConditions, // Kondisi atau kendala khusus
    String? customPromp) async {
  try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var prefResult = sharedPreferences.getString("lastGeneratedResult");
    if (prefResult != null) {
      return workoutRecommendationModelFromJson(extractJson(prefResult));
    }
    final response = await Gemini.instance.prompt(parts: [
      Part.text('''
        You are a fitness coach. Based on the user's input:
        Name: $name
        Age: $age
        Gender: $gender
        Activity Level: $fitnessLevel
        Goal: $goal
        Duration Available: $duration minutes per day
        Equipment Available: $equipment
        Workout Preference: $preference
        Availability: $availability
        Special Conditions: $specialConditions
        
        $customPromp
        Coba buat rekomendasi aktivitas yang sesuai, menggunakan alat yang tersedia, dan disesuaikan dengan kondisi pengguna. Buat rencana untuk 1 minggu dengan detail berikut:
       
        Format jawaban dalam JSON:
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
                "durasi": number,
                "aktivitas": [
                  {
                    "nama": "string",
                    "waktu": number,
                    "deskripsi": "string"
                  }
                ]
              }
            }
          ],
          "notes": "string"
        }
      ''')
    ]);
    if (response?.output == null) {
      return null;
    } else {
      sharedPreferences.setString("lastGeneratedResult", response!.output!);
      return workoutRecommendationModelFromJson(extractJson(response.output!));
    }
  } catch (e, s) {
    throw Exception(s.toString());
  }
}

String extractJson(String input) {
  return input.replaceAll("```", "").replaceAll("json", "");
}
