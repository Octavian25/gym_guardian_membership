// To parse this JSON data, do
//
//     final workoutRecommendationModel = workoutRecommendationModelFromJson(jsonString);

import 'dart:convert';

WorkoutRecommendationModel workoutRecommendationModelFromJson(String str) =>
    WorkoutRecommendationModel.fromJson(json.decode(str));

String workoutRecommendationModelToJson(WorkoutRecommendationModel data) =>
    json.encode(data.toJson());

class WorkoutRecommendationModel {
  final String programName;
  final ClientInfo clientInfo;
  final List<WeeklyPlan> weeklyPlan;
  final String notes;

  WorkoutRecommendationModel({
    required this.programName,
    required this.clientInfo,
    required this.weeklyPlan,
    required this.notes,
  });

  WorkoutRecommendationModel copyWith({
    String? programName,
    ClientInfo? clientInfo,
    List<WeeklyPlan>? weeklyPlan,
    String? notes,
  }) =>
      WorkoutRecommendationModel(
        programName: programName ?? this.programName,
        clientInfo: clientInfo ?? this.clientInfo,
        weeklyPlan: weeklyPlan ?? this.weeklyPlan,
        notes: notes ?? this.notes,
      );

  factory WorkoutRecommendationModel.fromJson(Map<String, dynamic> json) =>
      WorkoutRecommendationModel(
        programName: json["program_name"],
        clientInfo: ClientInfo.fromJson(json["client_info"]),
        weeklyPlan: List<WeeklyPlan>.from(json["weekly_plan"].map((x) => WeeklyPlan.fromJson(x))),
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "program_name": programName,
        "client_info": clientInfo.toJson(),
        "weekly_plan": List<dynamic>.from(weeklyPlan.map((x) => x.toJson())),
        "notes": notes,
      };
}

class ClientInfo {
  final int age;
  final String gender;
  final String fitnessLevel;
  final String goal;
  final int duration;

  ClientInfo({
    required this.age,
    required this.gender,
    required this.fitnessLevel,
    required this.goal,
    required this.duration,
  });

  ClientInfo copyWith({
    int? age,
    String? gender,
    String? fitnessLevel,
    String? goal,
    int? duration,
  }) =>
      ClientInfo(
        age: age ?? this.age,
        gender: gender ?? this.gender,
        fitnessLevel: fitnessLevel ?? this.fitnessLevel,
        goal: goal ?? this.goal,
        duration: duration ?? this.duration,
      );

  factory ClientInfo.fromJson(Map<String, dynamic> json) => ClientInfo(
        age: json["age"],
        gender: json["gender"],
        fitnessLevel: json["fitness_level"],
        goal: json["goal"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "gender": gender,
        "fitness_level": fitnessLevel,
        "goal": goal,
        "duration": duration,
      };
}

class WeeklyPlan {
  final String day;
  final Workout workout;

  WeeklyPlan({
    required this.day,
    required this.workout,
  });

  WeeklyPlan copyWith({
    String? day,
    Workout? workout,
  }) =>
      WeeklyPlan(
        day: day ?? this.day,
        workout: workout ?? this.workout,
      );

  factory WeeklyPlan.fromJson(Map<String, dynamic> json) => WeeklyPlan(
        day: json["day"],
        workout: Workout.fromJson(json["workout"]),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "workout": workout.toJson(),
      };
}

class Workout {
  final int duration;
  final List<Aktivita> activity;

  Workout({
    required this.duration,
    required this.activity,
  });

  Workout copyWith({
    int? duration,
    List<Aktivita>? activity,
  }) =>
      Workout(
        duration: duration ?? this.duration,
        activity: activity ?? this.activity,
      );

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        duration: json["duration"],
        activity: List<Aktivita>.from(json["activity"].map((x) => Aktivita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "activity": List<dynamic>.from(activity.map((x) => x.toJson())),
      };
}

class Aktivita {
  final String name;
  final int duration;
  final String description;

  Aktivita({
    required this.name,
    required this.duration,
    required this.description,
  });

  Aktivita copyWith({
    String? name,
    int? duration,
    String? description,
  }) =>
      Aktivita(
        name: name ?? this.name,
        duration: duration ?? this.duration,
        description: description ?? this.description,
      );

  factory Aktivita.fromJson(Map<String, dynamic> json) => Aktivita(
        name: json["name"],
        duration: json["duration"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "duraiton": duration,
        "description": description,
      };
}
