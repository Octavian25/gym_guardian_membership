// To parse this JSON data, do
//
//     final redeemableItemEntity = redeemableItemEntityFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';
import 'package:gym_guardian_membership/redeemable_item/data/models/redeemable_item_model.dart';

RedeemableItemEntity redeemableItemEntityFromJson(String str) =>
    RedeemableItemEntity.fromJson(json.decode(str));

String redeemableItemEntityToJson(RedeemableItemEntity data) => json.encode(data.toJson());

class RedeemableItemEntity {
  final List<DatumRedeemableItemEntity> data;
  final Meta meta;

  RedeemableItemEntity({
    required this.data,
    required this.meta,
  });

  RedeemableItemModel toModel() =>
      RedeemableItemModel(data: data.map((e) => e.toModel()).toList(), meta: meta);

  RedeemableItemEntity copyWith({
    List<DatumRedeemableItemEntity>? data,
    Meta? meta,
  }) =>
      RedeemableItemEntity(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory RedeemableItemEntity.fromJson(Map<String, dynamic> json) => RedeemableItemEntity(
        data: List<DatumRedeemableItemEntity>.from(
            json["data"].map((x) => DatumRedeemableItemEntity.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumRedeemableItemEntity {
  final String id;
  final int pointsRequired;
  final int quantityAvailable;
  final String status;
  final String inputBy;
  final DateTime inputDate;
  final String description;
  final String name;
  final int v;

  DatumRedeemableItemEntity({
    required this.id,
    required this.pointsRequired,
    required this.quantityAvailable,
    required this.status,
    required this.inputBy,
    required this.inputDate,
    required this.description,
    required this.name,
    required this.v,
  });

  DatumRedeemableItemModel toModel() => DatumRedeemableItemModel(
      id: id,
      pointsRequired: pointsRequired,
      quantityAvailable: quantityAvailable,
      status: status,
      inputBy: inputBy,
      inputDate: inputDate,
      description: description,
      name: name,
      v: v);

  DatumRedeemableItemEntity copyWith({
    String? id,
    int? pointsRequired,
    int? quantityAvailable,
    String? status,
    String? inputBy,
    DateTime? inputDate,
    String? description,
    String? name,
    int? v,
  }) =>
      DatumRedeemableItemEntity(
        id: id ?? this.id,
        pointsRequired: pointsRequired ?? this.pointsRequired,
        quantityAvailable: quantityAvailable ?? this.quantityAvailable,
        status: status ?? this.status,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
        description: description ?? this.description,
        name: name ?? this.name,
        v: v ?? this.v,
      );

  factory DatumRedeemableItemEntity.fromJson(Map<String, dynamic> json) =>
      DatumRedeemableItemEntity(
        id: json["_id"],
        pointsRequired: json["points_required"],
        quantityAvailable: json["quantity_available"],
        status: json["status"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]),
        description: json["description"],
        name: json["name"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "points_required": pointsRequired,
        "quantity_available": quantityAvailable,
        "status": status,
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
        "description": description,
        "name": name,
        "__v": v,
      };
}
