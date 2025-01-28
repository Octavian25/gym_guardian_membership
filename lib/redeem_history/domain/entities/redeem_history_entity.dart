import 'dart:convert';

import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';
import 'package:gym_guardian_membership/redeem_history/data/models/redeem_history_model.dart';

RedeemHistoryEntity redeemHistoryEntityFromJson(String str) =>
    RedeemHistoryEntity.fromJson(json.decode(str));

String redeemHistoryEntityToJson(RedeemHistoryEntity data) => json.encode(data.toJson());

class RedeemHistoryEntity {
  final List<DatumRedeemHistoryEntity> data;
  final Meta meta;

  RedeemHistoryEntity({
    required this.data,
    required this.meta,
  });

  RedeemHistoryEntity copyWith({
    List<DatumRedeemHistoryEntity>? data,
    Meta? meta,
  }) =>
      RedeemHistoryEntity(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  RedeemHistoryModel toModel() =>
      RedeemHistoryModel(data: data.map((e) => e.toModel()).toList(), meta: meta);

  factory RedeemHistoryEntity.fromJson(Map<String, dynamic> json) => RedeemHistoryEntity(
        data: List<DatumRedeemHistoryEntity>.from(
            json["data"].map((x) => DatumRedeemHistoryEntity.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumRedeemHistoryEntity {
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

  DatumRedeemHistoryEntity({
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

  DatumRedeemHistoryModel toModel() => DatumRedeemHistoryModel(
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

  DatumRedeemHistoryEntity copyWith({
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
      DatumRedeemHistoryEntity(
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

  factory DatumRedeemHistoryEntity.fromJson(Map<String, dynamic> json) => DatumRedeemHistoryEntity(
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
