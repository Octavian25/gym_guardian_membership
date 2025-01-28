// To parse this JSON data, do
//
//     final registerAttendanceResponseModel = registerAttendanceResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/homepage/domain/entities/register_attendance_reponse_entity.dart';

RegisterAttendanceResponseModel registerAttendanceResponseModelFromJson(String str) =>
    RegisterAttendanceResponseModel.fromJson(json.decode(str));

String registerAttendanceResponseModelToJson(RegisterAttendanceResponseModel data) =>
    json.encode(data.toJson());

class RegisterAttendanceResponseModel {
  final String memberCode;
  final String memberName;
  final String attendanceType;
  final DateTime attendanceDate;
  final String inputBy;
  final DateTime inputDate;
  final int pointsEarned;

  RegisterAttendanceResponseModel({
    required this.memberCode,
    required this.memberName,
    required this.attendanceType,
    required this.attendanceDate,
    required this.inputBy,
    required this.inputDate,
    required this.pointsEarned,
  });

  RegisterAttendanceResponseEntity toEntity() => RegisterAttendanceResponseEntity(
      memberCode: memberCode,
      memberName: memberName,
      attendanceType: attendanceType,
      attendanceDate: attendanceDate,
      inputBy: inputBy,
      inputDate: inputDate,
      pointsEarned: pointsEarned);

  RegisterAttendanceResponseModel copyWith({
    String? memberCode,
    String? memberName,
    String? attendanceType,
    DateTime? attendanceDate,
    String? inputBy,
    DateTime? inputDate,
    int? pointsEarned,
  }) =>
      RegisterAttendanceResponseModel(
        memberCode: memberCode ?? this.memberCode,
        memberName: memberName ?? this.memberName,
        attendanceType: attendanceType ?? this.attendanceType,
        attendanceDate: attendanceDate ?? this.attendanceDate,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
        pointsEarned: pointsEarned ?? this.pointsEarned,
      );

  factory RegisterAttendanceResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterAttendanceResponseModel(
        memberCode: json["member_code"],
        memberName: json["member_name"],
        attendanceType: json["attendance_type"],
        attendanceDate: DateTime.parse(json["attendance_date"]).toLocal(),
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]).toLocal(),
        pointsEarned: json["points_earned"],
      );

  Map<String, dynamic> toJson() => {
        "member_code": memberCode,
        "member_name": memberName,
        "attendance_type": attendanceType,
        "attendance_date":
            "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
        "points_earned": pointsEarned,
      };
}
