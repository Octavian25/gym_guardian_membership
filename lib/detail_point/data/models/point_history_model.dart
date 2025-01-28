// To parse this JSON data, do
//
//     final pointHistoryModel = pointHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';

PointHistoryModel pointHistoryModelFromJson(String str) =>
    PointHistoryModel.fromJson(json.decode(str));

String pointHistoryModelToJson(PointHistoryModel data) => json.encode(data.toJson());

class PointHistoryModel {
  final List<DatumPointHistoryModel> data;
  final Meta meta;

  PointHistoryModel({
    required this.data,
    required this.meta,
  });

  PointHistoryEntity toEntity() =>
      PointHistoryEntity(data: data.map((e) => e.toEntity()).toList(), meta: meta);

  PointHistoryModel copyWith({
    List<DatumPointHistoryModel>? data,
    Meta? meta,
  }) =>
      PointHistoryModel(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory PointHistoryModel.fromJson(Map<String, dynamic> json) => PointHistoryModel(
        data: List<DatumPointHistoryModel>.from(
            json["data"].map((x) => DatumPointHistoryModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumPointHistoryModel {
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

  DatumPointHistoryModel({
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

  DatumPointHistoryEntity toEntity() => DatumPointHistoryEntity(
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

  DatumPointHistoryModel copyWith({
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
      DatumPointHistoryModel(
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

  factory DatumPointHistoryModel.fromJson(Map<String, dynamic> json) => DatumPointHistoryModel(
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
