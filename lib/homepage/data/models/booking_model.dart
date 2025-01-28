// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/booking_entity.dart';

BookingModel bookingModelFromJson(String str) => BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) => json.encode(data.toJson());

class BookingModel {
  final List<DatumBookingModel> data;
  final Meta meta;

  BookingModel({
    required this.data,
    required this.meta,
  });

  BookingEntity toEntity() =>
      BookingEntity(data: data.map((e) => e.toEntity()).toList(), meta: meta);

  BookingModel copyWith({
    List<DatumBookingModel>? data,
    Meta? meta,
  }) =>
      BookingModel(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        data: List<DatumBookingModel>.from(json["data"].map((x) => DatumBookingModel.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumBookingModel {
  final String id;
  final String bookingDate;
  final String memberCode;
  final String status;
  final String inputBy;
  final DateTime inputDate;

  DatumBookingModel({
    required this.id,
    required this.bookingDate,
    required this.memberCode,
    required this.status,
    required this.inputBy,
    required this.inputDate,
  });

  DatumBookingEntity toEntity() => DatumBookingEntity(
      id: id,
      bookingDate: bookingDate,
      memberCode: memberCode,
      status: status,
      inputBy: inputBy,
      inputDate: inputDate);

  DatumBookingModel copyWith({
    String? id,
    String? bookingDate,
    String? memberCode,
    String? status,
    String? inputBy,
    DateTime? inputDate,
  }) =>
      DatumBookingModel(
        id: id ?? this.id,
        bookingDate: bookingDate ?? this.bookingDate,
        memberCode: memberCode ?? this.memberCode,
        status: status ?? this.status,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
      );

  factory DatumBookingModel.fromJson(Map<String, dynamic> json) => DatumBookingModel(
        id: json["_id"],
        bookingDate: json["booking_date"],
        memberCode: json["member_code"],
        status: json["status"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "booking_date": bookingDate,
        "member_code": memberCode,
        "status": status,
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
      };
}
