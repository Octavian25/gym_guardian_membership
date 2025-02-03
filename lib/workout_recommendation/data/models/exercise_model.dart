// To parse this JSON data, do
//
//     final exerciseModel = exerciseModelFromJson(jsonString);

import 'dart:convert';

ExerciseModel exerciseModelFromJson(String str) => ExerciseModel.fromJson(json.decode(str));

String exerciseModelToJson(ExerciseModel data) => json.encode(data.toJson());

class ExerciseModel {
  final String exerciseName;
  final String equipment;
  final int duration;
  final int sets;
  final int repsPerSet;
  final int restBetweenReps;
  final int restBetweenSets;
  final String benefits;
  final String howToDo;
  final String youtubeURL;

  ExerciseModel({
    required this.exerciseName,
    required this.equipment,
    required this.duration,
    required this.sets,
    required this.repsPerSet,
    required this.restBetweenReps,
    required this.restBetweenSets,
    required this.benefits,
    required this.howToDo,
    required this.youtubeURL,
  });

  ExerciseModel copyWith({
    String? exerciseName,
    String? equipment,
    int? duration,
    int? sets,
    int? repsPerSet,
    int? restBetweenReps,
    int? restBetweenSets,
    String? benefits,
    String? howToDo,
    String? youtubeURL,
  }) =>
      ExerciseModel(
        exerciseName: exerciseName ?? this.exerciseName,
        equipment: equipment ?? this.equipment,
        duration: duration ?? this.duration,
        sets: sets ?? this.sets,
        repsPerSet: repsPerSet ?? this.repsPerSet,
        restBetweenReps: restBetweenReps ?? this.restBetweenReps,
        restBetweenSets: restBetweenSets ?? this.restBetweenSets,
        benefits: benefits ?? this.benefits,
        howToDo: howToDo ?? this.howToDo,
        youtubeURL: youtubeURL ?? this.youtubeURL,
      );

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
        exerciseName: json["exercise_name"],
        equipment: json["equipment"],
        duration: json["duration"],
        sets: json["sets"],
        repsPerSet: json["reps_per_set"],
        restBetweenReps: json["rest_between_reps"],
        restBetweenSets: json["rest_between_sets"],
        benefits: json["benefits"],
        howToDo: json["how_to_do"],
        youtubeURL: json["tutorial_youtube_url"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "exercise_name": exerciseName,
        "equipment": equipment,
        "duration": duration,
        "sets": sets,
        "reps_per_set": repsPerSet,
        "rest_between_reps": restBetweenReps,
        "rest_between_sets": restBetweenSets,
        "benefits": benefits,
        "how_to_do": howToDo,
        "tutorial_youtube_url": youtubeURL,
      };
}
