// To parse this JSON data, do
//
//     final activityMemberModel = activityMemberModelFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';

ActivityMemberModel activityMemberModelFromJson(String str) =>
    ActivityMemberModel.fromJson(json.decode(str));

String activityMemberModelToJson(ActivityMemberModel data) => json.encode(data.toJson());

class ActivityMemberModel {
  final List<DatumActivityMemberModel> data;
  final Meta meta;

  ActivityMemberModel({
    required this.data,
    required this.meta,
  });

  ActivityMemberEntity toEntity() =>
      ActivityMemberEntity(data: data.map((e) => e.toEntity()).toList(), meta: meta);

  ActivityMemberModel copyWith({
    List<DatumActivityMemberModel>? data,
    Meta? meta,
  }) =>
      ActivityMemberModel(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory ActivityMemberModel.fromJson(Map<String, dynamic> json) => ActivityMemberModel(
        data: List<DatumActivityMemberModel>.from(
            json["data"].map((x) => DatumActivityMemberModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumActivityMemberModel {
  final String id;
  final String attendanceType;
  final int pointsEarned;
  final String memberCode;
  final String memberName;
  final DateTime attendanceDate;
  final DateTime inputDate;
  final int v;

  DatumActivityMemberModel({
    required this.id,
    required this.attendanceType,
    required this.pointsEarned,
    required this.memberCode,
    required this.memberName,
    required this.attendanceDate,
    required this.inputDate,
    required this.v,
  });

  DatumActivityMemberEntity toEntity() => DatumActivityMemberEntity(
      id: id,
      attendanceType: attendanceType,
      pointsEarned: pointsEarned,
      memberCode: memberCode,
      memberName: memberName,
      attendanceDate: attendanceDate,
      inputDate: inputDate,
      v: v);

  DatumActivityMemberModel copyWith({
    String? id,
    String? attendanceType,
    int? pointsEarned,
    String? memberCode,
    String? memberName,
    DateTime? attendanceDate,
    DateTime? inputDate,
    int? v,
  }) =>
      DatumActivityMemberModel(
        id: id ?? this.id,
        attendanceType: attendanceType ?? this.attendanceType,
        pointsEarned: pointsEarned ?? this.pointsEarned,
        memberCode: memberCode ?? this.memberCode,
        memberName: memberName ?? this.memberName,
        attendanceDate: attendanceDate ?? this.attendanceDate,
        inputDate: inputDate ?? this.inputDate,
        v: v ?? this.v,
      );

  factory DatumActivityMemberModel.fromJson(Map<String, dynamic> json) => DatumActivityMemberModel(
        id: json["_id"],
        attendanceType: json["attendance_type"],
        pointsEarned: json["points_earned"],
        memberCode: json["member_code"],
        memberName: json["member_name"],
        attendanceDate: DateTime.parse(json["attendance_date"]).toLocal(),
        inputDate: DateTime.parse(json["input_date"]).toLocal(),
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

class Meta {
  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;

  Meta({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
  });

  Meta copyWith({
    int? page,
    int? limit,
    int? totalItems,
    int? totalPages,
  }) =>
      Meta(
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "totalItems": totalItems,
        "totalPages": totalPages,
      };
}
