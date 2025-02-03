import 'package:gym_guardian_membership/register/domain/entities/register_request_entity.dart';

class RegisterRequestModel {
  final String memberName;
  final String memberEmail;
  final String packageCode;
  final String password;
  final String noHandphone;
  final int age;
  final int weight;
  final int height;
  final String workoutDuration;
  final String activityLevel;
  final String fitnessGoal;
  final String gender;
  final List<String> workoutPreferences;
  final String availableTime;
  final String specialCondition;

  RegisterRequestModel(
      {required this.memberName,
      required this.memberEmail,
      required this.packageCode,
      required this.password,
      required this.noHandphone,
      required this.age,
      required this.weight,
      required this.height,
      required this.activityLevel,
      required this.fitnessGoal,
      required this.specialCondition,
      required this.workoutPreferences,
      required this.workoutDuration,
      required this.gender,
      required this.availableTime});

  RegisterRequestEntity toEntity() => RegisterRequestEntity(
      memberName: memberName,
      memberEmail: memberEmail,
      packageCode: packageCode,
      password: password,
      noHandphone: noHandphone,
      activityLevel: activityLevel,
      age: age,
      availableTime: availableTime,
      fitnessGoal: fitnessGoal,
      height: height,
      weight: weight,
      specialCondition: specialCondition,
      workoutDuration: workoutDuration,
      gender: gender,
      workoutPreferences: workoutPreferences);

  RegisterRequestModel copyWith(
          {String? memberName,
          String? memberEmail,
          String? packageCode,
          String? password,
          String? noHandphone,
          int? age,
          int? weight,
          int? height,
          String? activityLevel,
          String? fitnessGoal,
          String? specialCondition,
          String? workoutDuration,
          String? gender,
          List<String>? workoutPreferences,
          String? availableTime}) =>
      RegisterRequestModel(
          memberName: memberName ?? this.memberName,
          memberEmail: memberEmail ?? this.memberEmail,
          packageCode: packageCode ?? this.packageCode,
          password: password ?? this.password,
          noHandphone: noHandphone ?? this.noHandphone,
          age: age ?? this.age,
          weight: weight ?? this.weight,
          height: height ?? this.height,
          specialCondition: specialCondition ?? this.specialCondition,
          activityLevel: activityLevel ?? this.activityLevel,
          fitnessGoal: fitnessGoal ?? this.fitnessGoal,
          workoutPreferences: workoutPreferences ?? this.workoutPreferences,
          workoutDuration: workoutDuration ?? this.workoutDuration,
          gender: gender ?? this.gender,
          availableTime: availableTime ?? this.availableTime);

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => RegisterRequestModel(
      memberName: json["member_name"],
      memberEmail: json["member_email"],
      packageCode: json["package_code"],
      password: json["password"],
      noHandphone: json["no_handphone"],
      activityLevel: json["activity_level"],
      age: json["age"],
      availableTime: json['available_time'],
      fitnessGoal: json["fitness_goal"],
      height: json['height'],
      weight: json['weight'],
      specialCondition: json['special_condition'],
      workoutDuration: json['workout_duration'],
      gender: json['gender'],
      workoutPreferences: List<String>.from(json['workout_preferences'].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "member_name": memberName,
        "member_email": memberEmail,
        "package_code": packageCode,
        "password": password,
        "no_handphone": noHandphone,
        "activity_level": activityLevel,
        "age": age,
        "available_time": availableTime,
        "fitness_goal": fitnessGoal,
        "height": height,
        "weight": weight,
        "gender": gender,
        "special_condition": specialCondition,
        "workout_duration": workoutDuration,
        "workout_preferences": List<dynamic>.from(workoutPreferences.map((x) => x))
      };
}
