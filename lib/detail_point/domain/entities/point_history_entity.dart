// To parse this JSON data, do
//
//     final pointHistoryEntity = pointHistoryEntityFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/detail_point/data/models/point_history_model.dart';
import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';

PointHistoryEntity pointHistoryEntityFromJson(String str) =>
    PointHistoryEntity.fromJson(json.decode(str));

String pointHistoryEntityToJson(PointHistoryEntity data) => json.encode(data.toJson());

class PointHistoryEntity {
  final List<DatumPointHistoryEntity> data;
  final Meta meta;

  PointHistoryEntity({
    required this.data,
    required this.meta,
  });

  PointHistoryModel toEntity() =>
      PointHistoryModel(data: data.map((e) => e.toEntity()).toList(), meta: meta);

  PointHistoryEntity copyWith({
    List<DatumPointHistoryEntity>? data,
    Meta? meta,
  }) =>
      PointHistoryEntity(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory PointHistoryEntity.fromJson(Map<String, dynamic> json) => PointHistoryEntity(
        data: List<DatumPointHistoryEntity>.from(
            json["data"].map((x) => DatumPointHistoryEntity.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumPointHistoryEntity {
  final String id;
  final String memberCode;
  final int pointAwal;
  final int pointIn;
  final int pointOut;
  final int pointAkhir;
  final String status;
  final String inputBy;
  final DateTime inputDate;
  final int v;
  final String description;

  DatumPointHistoryEntity({
    required this.id,
    required this.memberCode,
    required this.pointAwal,
    required this.pointIn,
    required this.pointOut,
    required this.pointAkhir,
    required this.status,
    required this.inputBy,
    required this.inputDate,
    required this.v,
    required this.description,
  });

  DatumPointHistoryModel toEntity() => DatumPointHistoryModel(
      id: id,
      memberCode: memberCode,
      pointAwal: pointAwal,
      pointIn: pointIn,
      pointOut: pointOut,
      pointAkhir: pointAkhir,
      status: status,
      inputBy: inputBy,
      inputDate: inputDate,
      v: v,
      description: description);

  DatumPointHistoryEntity copyWith({
    String? id,
    String? memberCode,
    int? pointAwal,
    int? pointIn,
    int? pointOut,
    int? pointAkhir,
    String? status,
    String? inputBy,
    DateTime? inputDate,
    int? v,
    String? description,
  }) =>
      DatumPointHistoryEntity(
        id: id ?? this.id,
        memberCode: memberCode ?? this.memberCode,
        pointAwal: pointAwal ?? this.pointAwal,
        pointIn: pointIn ?? this.pointIn,
        pointOut: pointOut ?? this.pointOut,
        pointAkhir: pointAkhir ?? this.pointAkhir,
        status: status ?? this.status,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
        v: v ?? this.v,
        description: description ?? this.description,
      );

  factory DatumPointHistoryEntity.fromJson(Map<String, dynamic> json) => DatumPointHistoryEntity(
        id: json["_id"],
        memberCode: json["member_code"],
        pointAwal: json["point_awal"],
        pointIn: json["point_in"],
        pointOut: json["point_out"],
        pointAkhir: json["point_akhir"],
        status: json["status"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]),
        v: json["__v"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "member_code": memberCode,
        "point_awal": pointAwal,
        "point_in": pointIn,
        "point_out": pointOut,
        "point_akhir": pointAkhir,
        "status": status,
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
        "__v": v,
        "description": description,
      };
}
