import 'package:gym_guardian_membership/register/data/models/register_request_model.dart';

class RegisterRequestEntity {
  final String memberName;
  final String memberEmail;
  final String packageCode;
  final String password;
  final String noHandphone;
  final int age;
  final int weight;
  final int height;
  final String activityLevel;
  final String fitnessGoal;
  final List<String> workoutPreferences;
  final String availableTime;

  RegisterRequestEntity(
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
      required this.workoutPreferences,
      required this.availableTime});

  RegisterRequestModel toModel() => RegisterRequestModel(
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
      workoutPreferences: workoutPreferences);

  RegisterRequestEntity copyWith(
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
          List<String>? workoutPreferences,
          String? availableTime}) =>
      RegisterRequestEntity(
          memberName: memberName ?? this.memberName,
          memberEmail: memberEmail ?? this.memberEmail,
          packageCode: packageCode ?? this.packageCode,
          password: password ?? this.password,
          noHandphone: noHandphone ?? this.noHandphone,
          age: age ?? this.age,
          weight: weight ?? this.weight,
          height: height ?? this.height,
          activityLevel: activityLevel ?? this.activityLevel,
          fitnessGoal: fitnessGoal ?? this.fitnessGoal,
          workoutPreferences: workoutPreferences ?? this.workoutPreferences,
          availableTime: availableTime ?? this.availableTime);

  factory RegisterRequestEntity.fromJson(Map<String, dynamic> json) => RegisterRequestEntity(
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
        "heigt": height,
        "weight": weight,
        "workout_preferences": List<dynamic>.from(workoutPreferences.map((x) => x))
      };
}
