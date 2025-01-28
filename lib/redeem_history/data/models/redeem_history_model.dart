import 'dart:convert';

import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';
import 'package:gym_guardian_membership/redeem_history/domain/entities/redeem_history_entity.dart';

RedeemHistoryModel redeemHistoryModelFromJson(String str) =>
    RedeemHistoryModel.fromJson(json.decode(str));

String redeemHistoryModelToJson(RedeemHistoryModel data) => json.encode(data.toJson());

class RedeemHistoryModel {
  final List<DatumRedeemHistoryModel> data;
  final Meta meta;

  RedeemHistoryModel({
    required this.data,
    required this.meta,
  });

  RedeemHistoryEntity toEntity() =>
      RedeemHistoryEntity(data: data.map((e) => e.toEntity()).toList(), meta: meta);

  RedeemHistoryModel copyWith({
    List<DatumRedeemHistoryModel>? data,
    Meta? meta,
  }) =>
      RedeemHistoryModel(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory RedeemHistoryModel.fromJson(Map<String, dynamic> json) => RedeemHistoryModel(
        data: List<DatumRedeemHistoryModel>.from(
            json["data"].map((x) => DatumRedeemHistoryModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumRedeemHistoryModel {
  final String id;
  final String memberId;
  final String memberCode;
  final String itemId;
  final String itemName;
  final int pointsUsed;
  final int quantity;
  final DateTime redeemDate;
  final String status;
  final String transactionId;
  final int totalPointsBefore;
  final int totalPointsAfter;
  final String redeemMethod;
  final String inputBy;
  final DateTime inputDate;

  DatumRedeemHistoryModel({
    required this.id,
    required this.memberId,
    required this.memberCode,
    required this.itemId,
    required this.itemName,
    required this.pointsUsed,
    required this.quantity,
    required this.redeemDate,
    required this.status,
    required this.transactionId,
    required this.totalPointsBefore,
    required this.totalPointsAfter,
    required this.redeemMethod,
    required this.inputBy,
    required this.inputDate,
  });

  DatumRedeemHistoryEntity toEntity() => DatumRedeemHistoryEntity(
      id: id,
      memberId: memberId,
      memberCode: memberCode,
      itemId: itemId,
      itemName: itemName,
      pointsUsed: pointsUsed,
      quantity: quantity,
      redeemDate: redeemDate,
      status: status,
      transactionId: transactionId,
      totalPointsBefore: totalPointsBefore,
      totalPointsAfter: totalPointsAfter,
      redeemMethod: redeemMethod,
      inputBy: inputBy,
      inputDate: inputDate);

  DatumRedeemHistoryModel copyWith({
    String? id,
    String? memberId,
    String? memberCode,
    String? itemId,
    String? itemName,
    int? pointsUsed,
    int? quantity,
    DateTime? redeemDate,
    String? status,
    String? transactionId,
    int? totalPointsBefore,
    int? totalPointsAfter,
    String? redeemMethod,
    String? inputBy,
    DateTime? inputDate,
  }) =>
      DatumRedeemHistoryModel(
        id: id ?? this.id,
        memberId: memberId ?? this.memberId,
        memberCode: memberCode ?? this.memberCode,
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        pointsUsed: pointsUsed ?? this.pointsUsed,
        quantity: quantity ?? this.quantity,
        redeemDate: redeemDate ?? this.redeemDate,
        status: status ?? this.status,
        transactionId: transactionId ?? this.transactionId,
        totalPointsBefore: totalPointsBefore ?? this.totalPointsBefore,
        totalPointsAfter: totalPointsAfter ?? this.totalPointsAfter,
        redeemMethod: redeemMethod ?? this.redeemMethod,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
      );

  factory DatumRedeemHistoryModel.fromJson(Map<String, dynamic> json) => DatumRedeemHistoryModel(
        id: json["_id"],
        memberId: json["member_id"],
        memberCode: json["member_code"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        pointsUsed: json["points_used"],
        quantity: json["quantity"],
        redeemDate: DateTime.parse(json["redeem_date"]),
        status: json["status"],
        transactionId: json["transaction_id"],
        totalPointsBefore: json["total_points_before"],
        totalPointsAfter: json["total_points_after"],
        redeemMethod: json["redeem_method"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "member_id": memberId,
        "member_code": memberCode,
        "item_id": itemId,
        "item_name": itemName,
        "points_used": pointsUsed,
        "quantity": quantity,
        "redeem_date": redeemDate.toIso8601String(),
        "status": status,
        "transaction_id": transactionId,
        "total_points_before": totalPointsBefore,
        "total_points_after": totalPointsAfter,
        "redeem_method": redeemMethod,
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
      };
}
