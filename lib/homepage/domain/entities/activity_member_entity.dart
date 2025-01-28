// To parse this JSON data, do
//
//     final activityMemberEntity = activityMemberEntityFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';

ActivityMemberEntity activityMemberEntityFromJson(String str) =>
    ActivityMemberEntity.fromJson(json.decode(str));

String activityMemberEntityToJson(ActivityMemberEntity data) => json.encode(data.toJson());

class ActivityMemberEntity {
  final List<DatumActivityMemberEntity> data;
  final Meta meta;

  ActivityMemberEntity({
    required this.data,
    required this.meta,
  });

  ActivityMemberModel toModel() =>
      ActivityMemberModel(data: data.map((e) => e.toModel()).toList(), meta: meta);

  ActivityMemberEntity copyWith({
    List<DatumActivityMemberEntity>? data,
    Meta? meta,
  }) =>
      ActivityMemberEntity(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory ActivityMemberEntity.fromJson(Map<String, dynamic> json) => ActivityMemberEntity(
        data: List<DatumActivityMemberEntity>.from(
            json["data"].map((x) => DatumActivityMemberEntity.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumActivityMemberEntity {
  final String id;
  final String attendanceType;
  final int pointsEarned;
  final String memberCode;
  final String memberName;
  final DateTime attendanceDate;
  final DateTime inputDate;
  final int v;

  DatumActivityMemberEntity({
    required this.id,
    required this.attendanceType,
    required this.pointsEarned,
    required this.memberCode,
    required this.memberName,
    required this.attendanceDate,
    required this.inputDate,
    required this.v,
  });

  DatumActivityMemberModel toModel() => DatumActivityMemberModel(
      id: id,
      attendanceType: attendanceType,
      pointsEarned: pointsEarned,
      memberCode: memberCode,
      memberName: memberName,
      attendanceDate: attendanceDate,
      inputDate: inputDate,
      v: v);

  DatumActivityMemberEntity copyWith({
    String? id,
    String? attendanceType,
    int? pointsEarned,
    String? memberCode,
    String? memberName,
    DateTime? attendanceDate,
    DateTime? inputDate,
    int? v,
  }) =>
      DatumActivityMemberEntity(
        id: id ?? this.id,
        attendanceType: attendanceType ?? this.attendanceType,
        pointsEarned: pointsEarned ?? this.pointsEarned,
        memberCode: memberCode ?? this.memberCode,
        memberName: memberName ?? this.memberName,
        attendanceDate: attendanceDate ?? this.attendanceDate,
        inputDate: inputDate ?? this.inputDate,
        v: v ?? this.v,
      );

  factory DatumActivityMemberEntity.fromJson(Map<String, dynamic> json) =>
      DatumActivityMemberEntity(
        id: json["_id"],
        attendanceType: json["attendance_type"],
        pointsEarned: json["points_earned"],
        memberCode: json["member_code"],
        memberName: json["member_name"],
        attendanceDate: DateTime.parse(json["attendance_date"]),
        inputDate: DateTime.parse(json["input_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "attendance_type": attendanceType,
        "points_earned": pointsEarned,
        "member_code": memberCode,
        "member_name": memberName,
        "attendance_date":
            "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
        "input_date": inputDate.toIso8601String(),
        "__v": v,
      };
}
