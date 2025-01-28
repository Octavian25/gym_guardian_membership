// To parse this JSON data, do
//
//     final registerAttendanceResponseEntity = registerAttendanceResponseEntityFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/homepage/data/models/register_attendance_response_model.dart';

RegisterAttendanceResponseEntity registerAttendanceResponseEntityFromJson(String str) =>
    RegisterAttendanceResponseEntity.fromJson(json.decode(str));

String registerAttendanceResponseEntityToJson(RegisterAttendanceResponseEntity data) =>
    json.encode(data.toJson());

class RegisterAttendanceResponseEntity {
  final String memberCode;
  final String memberName;
  final String attendanceType;
  final DateTime attendanceDate;
  final String inputBy;
  final DateTime inputDate;
  final int pointsEarned;

  RegisterAttendanceResponseEntity({
    required this.memberCode,
    required this.memberName,
    required this.attendanceType,
    required this.attendanceDate,
    required this.inputBy,
    required this.inputDate,
    required this.pointsEarned,
  });

  RegisterAttendanceResponseModel toModel() => RegisterAttendanceResponseModel(
      memberCode: memberCode,
      memberName: memberName,
      attendanceType: attendanceType,
      attendanceDate: attendanceDate,
      inputBy: inputBy,
      inputDate: inputDate,
      pointsEarned: pointsEarned);

  RegisterAttendanceResponseEntity copyWith({
    String? memberCode,
    String? memberName,
    String? attendanceType,
    DateTime? attendanceDate,
    String? inputBy,
    DateTime? inputDate,
    int? pointsEarned,
  }) =>
      RegisterAttendanceResponseEntity(
        memberCode: memberCode ?? this.memberCode,
        memberName: memberName ?? this.memberName,
        attendanceType: attendanceType ?? this.attendanceType,
        attendanceDate: attendanceDate ?? this.attendanceDate,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
        pointsEarned: pointsEarned ?? this.pointsEarned,
      );

  factory RegisterAttendanceResponseEntity.fromJson(Map<String, dynamic> json) =>
      RegisterAttendanceResponseEntity(
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
