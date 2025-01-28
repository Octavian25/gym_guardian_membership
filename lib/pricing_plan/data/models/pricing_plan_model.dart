import 'dart:convert';

import 'package:gym_guardian_membership/pricing_plan/domain/entities/pricing_plan_entity.dart';

List<PricingPlanModel> pricingPlanModelFromJson(List<dynamic> data) =>
    List<PricingPlanModel>.from(data.map((x) => PricingPlanModel.fromJson(x)));

String pricingPlanModelToJson(List<PricingPlanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PricingPlanModel {
  final String id;
  final String packageCode;
  final String packageName;
  final int price;
  final int duration;

  PricingPlanModel({
    required this.id,
    required this.packageCode,
    required this.packageName,
    required this.price,
    required this.duration,
  });

  PricingPlanEntity toEntity() => PricingPlanEntity(
      id: id, packageCode: packageCode, packageName: packageName, price: price, duration: duration);

  PricingPlanModel copyWith({
    String? id,
    String? packageCode,
    String? packageName,
    int? price,
    int? duration,
  }) =>
      PricingPlanModel(
        id: id ?? this.id,
        packageCode: packageCode ?? this.packageCode,
        packageName: packageName ?? this.packageName,
        price: price ?? this.price,
        duration: duration ?? this.duration,
      );

  factory PricingPlanModel.fromJson(Map<String, dynamic> json) => PricingPlanModel(
        id: json["_id"],
        packageCode: json["package_code"],
        packageName: json["package_name"],
        price: json["price"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "package_code": packageCode,
        "package_name": packageName,
        "price": price,
        "duration": duration,
      };
}
