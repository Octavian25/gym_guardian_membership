// To parse this JSON data, do
//
//     final bookingEntity = bookingEntityFromJson(jsonString);

import 'dart:convert';
import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';
import 'package:gym_guardian_membership/homepage/data/models/booking_model.dart';

BookingEntity bookingEntityFromJson(String str) => BookingEntity.fromJson(json.decode(str));

String bookingEntityToJson(BookingEntity data) => json.encode(data.toJson());

class BookingEntity {
  final List<DatumBookingEntity> data;
  final Meta meta;

  BookingEntity({
    required this.data,
    required this.meta,
  });

  BookingModel toModel() => BookingModel(data: data.map((e) => e.toModel()).toList(), meta: meta);

  BookingEntity copyWith({
    List<DatumBookingEntity>? data,
    Meta? meta,
  }) =>
      BookingEntity(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory BookingEntity.fromJson(Map<String, dynamic> json) => BookingEntity(
        data:
            List<DatumBookingEntity>.from(json["data"].map((x) => DatumBookingEntity.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumBookingEntity {
  final String id;
  final String bookingDate;
  final String memberCode;
  final String status;
  final String inputBy;
  final DateTime inputDate;

  DatumBookingEntity({
    required this.id,
    required this.bookingDate,
    required this.memberCode,
    required this.status,
    required this.inputBy,
    required this.inputDate,
  });

  DatumBookingModel toModel() => DatumBookingModel(
      id: id,
      bookingDate: bookingDate,
      memberCode: memberCode,
      status: status,
      inputBy: inputBy,
      inputDate: inputDate);

  DatumBookingEntity copyWith({
    String? id,
    String? bookingDate,
    String? memberCode,
    String? status,
    String? inputBy,
    DateTime? inputDate,
  }) =>
      DatumBookingEntity(
        id: id ?? this.id,
        bookingDate: bookingDate ?? this.bookingDate,
        memberCode: memberCode ?? this.memberCode,
        status: status ?? this.status,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
      );

  factory DatumBookingEntity.fromJson(Map<String, dynamic> json) => DatumBookingEntity(
        id: json["_id"],
        bookingDate: json["booking_date"],
        memberCode: json["member_code"],
        status: json["status"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]),
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
