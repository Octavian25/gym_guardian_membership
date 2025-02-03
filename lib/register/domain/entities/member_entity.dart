// To parse this JSON data, do
//
//     final memberEntity = memberEntityFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/register/data/models/member_model.dart';

MemberEntity memberEntityFromJson(String str) => MemberEntity.fromJson(json.decode(str));

String memberEntityToJson(MemberEntity data) => json.encode(data.toJson());

class MemberEntity {
  final String id;
  final String level;
  final bool onSite;
  final bool loginStatus;
  final List<String> workoutPreferences;
  final String memberCode;
  final String memberName;
  final String memberEmail;
  final String packageCode;
  final String packageName;
  final int price;
  final String noHandphone;
  final int point;
  final String ifid;
  final String expiredDate;
  final String password;
  final bool status;
  final String activityLevel;
  final int age;
  final String availableTime;
  final String fitnessGoal;
  final String specialCondition;
  final String workoutDuration;
  final String gender;
  final int weight;
  final int height;
  final String inputBy;
  final DateTime inputDate;

  MemberModel toModel() => MemberModel(
      id: id,
      level: level,
      onSite: onSite,
      loginStatus: loginStatus,
      workoutPreferences: workoutPreferences,
      memberCode: memberCode,
      memberName: memberName,
      memberEmail: memberEmail,
      packageCode: packageCode,
      packageName: packageName,
      price: price,
      noHandphone: noHandphone,
      point: point,
      ifid: ifid,
      expiredDate: expiredDate,
      password: password,
      status: status,
      activityLevel: activityLevel,
      age: age,
      availableTime: availableTime,
      fitnessGoal: fitnessGoal,
      specialCondition: specialCondition,
      workoutDuration: workoutDuration,
      gender: gender,
      weight: weight,
      height: height,
      inputBy: inputBy,
      inputDate: inputDate);

  MemberEntity({
    required this.id,
    required this.level,
    required this.onSite,
    required this.loginStatus,
    required this.workoutPreferences,
    required this.memberCode,
    required this.memberName,
    required this.memberEmail,
    required this.packageCode,
    required this.packageName,
    required this.price,
    required this.noHandphone,
    required this.point,
    required this.ifid,
    required this.expiredDate,
    required this.password,
    required this.status,
    required this.activityLevel,
    required this.age,
    required this.availableTime,
    required this.fitnessGoal,
    required this.specialCondition,
    required this.workoutDuration,
    required this.gender,
    required this.weight,
    required this.height,
    required this.inputBy,
    required this.inputDate,
  });

  MemberEntity copyWith({
    String? id,
    String? level,
    bool? onSite,
    bool? loginStatus,
    List<String>? workoutPreferences,
    String? memberCode,
    String? memberName,
    String? memberEmail,
    String? packageCode,
    String? packageName,
    int? price,
    String? noHandphone,
    int? point,
    String? ifid,
    String? expiredDate,
    String? password,
    bool? status,
    String? activityLevel,
    int? age,
    String? availableTime,
    String? fitnessGoal,
    String? specialCondition,
    String? workoutDuration,
    String? gender,
    int? weight,
    int? height,
    String? inputBy,
    DateTime? inputDate,
  }) =>
      MemberEntity(
        id: id ?? this.id,
        level: level ?? this.level,
        onSite: onSite ?? this.onSite,
        loginStatus: loginStatus ?? this.loginStatus,
        workoutPreferences: workoutPreferences ?? this.workoutPreferences,
        memberCode: memberCode ?? this.memberCode,
        memberName: memberName ?? this.memberName,
        memberEmail: memberEmail ?? this.memberEmail,
        packageCode: packageCode ?? this.packageCode,
        packageName: packageName ?? this.packageName,
        price: price ?? this.price,
        noHandphone: noHandphone ?? this.noHandphone,
        point: point ?? this.point,
        ifid: ifid ?? this.ifid,
        expiredDate: expiredDate ?? this.expiredDate,
        password: password ?? this.password,
        status: status ?? this.status,
        activityLevel: activityLevel ?? this.activityLevel,
        age: age ?? this.age,
        availableTime: availableTime ?? this.availableTime,
        fitnessGoal: fitnessGoal ?? this.fitnessGoal,
        specialCondition: specialCondition ?? this.specialCondition,
        workoutDuration: workoutDuration ?? this.workoutDuration,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
      );

  factory MemberEntity.fromJson(Map<String, dynamic> json) => MemberEntity(
        id: json["_id"],
        level: json["level"],
        onSite: json["on_site"],
        loginStatus: json["login_status"],
        workoutPreferences: List<String>.from(json["workout_preferences"].map((x) => x)),
        memberCode: json["member_code"],
        memberName: json["member_name"],
        memberEmail: json["member_email"],
        packageCode: json["package_code"],
        packageName: json["package_name"],
        price: json["price"],
        noHandphone: json["no_handphone"],
        point: json["point"],
        ifid: json["ifid"],
        expiredDate: json["expired_date"],
        password: json["password"],
        status: json["status"],
        activityLevel: json["activity_level"],
        age: json["age"],
        availableTime: json["available_time"],
        fitnessGoal: json["fitness_goal"],
        specialCondition: json["special_condition"],
        workoutDuration: json["workout_duration"],
        gender: json["gender"],
        weight: json["weight"],
        height: json["height"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "level": level,
        "on_site": onSite,
        "login_status": loginStatus,
        "workout_preferences": List<dynamic>.from(workoutPreferences.map((x) => x)),
        "member_code": memberCode,
        "member_name": memberName,
        "member_email": memberEmail,
        "package_code": packageCode,
        "package_name": packageName,
        "price": price,
        "no_handphone": noHandphone,
        "point": point,
        "ifid": ifid,
        "expired_date": expiredDate,
        "password": password,
        "status": status,
        "activity_level": activityLevel,
        "age": age,
        "available_time": availableTime,
        "fitness_goal": fitnessGoal,
        "special_condition": specialCondition,
        "workout_duration": workoutDuration,
        "gender": gender,
        "weight": weight,
        "height": height,
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
      };
}
