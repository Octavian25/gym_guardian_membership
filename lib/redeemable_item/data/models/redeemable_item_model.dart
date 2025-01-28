// To parse this JSON data, do
//
//     final redeemableItemModel = redeemableItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/entities/redeemable_item_entity.dart';

RedeemableItemModel redeemableItemModelFromJson(String str) =>
    RedeemableItemModel.fromJson(json.decode(str));

String redeemableItemModelToJson(RedeemableItemModel data) => json.encode(data.toJson());

class RedeemableItemModel {
  final List<DatumRedeemableItemModel> data;
  final Meta meta;

  RedeemableItemModel({
    required this.data,
    required this.meta,
  });

  RedeemableItemEntity toEntity() =>
      RedeemableItemEntity(data: data.map((e) => e.toEntity()).toList(), meta: meta);

  RedeemableItemModel copyWith({
    List<DatumRedeemableItemModel>? data,
    Meta? meta,
  }) =>
      RedeemableItemModel(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory RedeemableItemModel.fromJson(Map<String, dynamic> json) => RedeemableItemModel(
        data: List<DatumRedeemableItemModel>.from(
            json["data"].map((x) => DatumRedeemableItemModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumRedeemableItemModel {
  final String id;
  final int pointsRequired;
  final int quantityAvailable;
  final String status;
  final String inputBy;
  final DateTime inputDate;
  final String description;
  final String name;
  final int v;

  DatumRedeemableItemModel({
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

  DatumRedeemableItemEntity toEntity() => DatumRedeemableItemEntity(
      id: id,
      pointsRequired: pointsRequired,
      quantityAvailable: quantityAvailable,
      status: status,
      inputBy: inputBy,
      inputDate: inputDate,
      description: description,
      name: name,
      v: v);

  DatumRedeemableItemModel copyWith({
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
      DatumRedeemableItemModel(
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

  factory DatumRedeemableItemModel.fromJson(Map<String, dynamic> json) => DatumRedeemableItemModel(
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
