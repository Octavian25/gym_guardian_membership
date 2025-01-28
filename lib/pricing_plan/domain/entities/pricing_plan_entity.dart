import 'dart:convert';

import 'package:gym_guardian_membership/pricing_plan/data/models/pricing_plan_model.dart';

List<PricingPlanEntity> pricingPlanEntityFromJson(List<dynamic> data) =>
    List<PricingPlanEntity>.from(data.map((x) => PricingPlanEntity.fromJson(x)));

String pricingPlanEntityToJson(List<PricingPlanEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PricingPlanEntity {
  final String id;
  final String packageCode;
  final String packageName;
  final int price;
  final int duration;

  PricingPlanEntity({
    required this.id,
    required this.packageCode,
    required this.packageName,
    required this.price,
    required this.duration,
  });

  PricingPlanModel toModel() => PricingPlanModel(
      id: id, packageCode: packageCode, packageName: packageName, price: price, duration: duration);

  PricingPlanEntity copyWith({
    String? id,
    String? packageCode,
    String? packageName,
    int? price,
    int? duration,
  }) =>
      PricingPlanEntity(
        id: id ?? this.id,
        packageCode: packageCode ?? this.packageCode,
        packageName: packageName ?? this.packageName,
        price: price ?? this.price,
        duration: duration ?? this.duration,
      );

  factory PricingPlanEntity.fromJson(Map<String, dynamic> json) => PricingPlanEntity(
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
