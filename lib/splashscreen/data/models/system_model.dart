import 'dart:convert';

import 'package:gym_guardian_membership/splashscreen/domain/entities/system_entity.dart';

class SystemModel {
  final String id;
  final int pointReference;
  final int timeReference;
  final int maxBookingQuota;
  final String status;
  final String inputBy;
  final DateTime inputDate;
  final double locationLatitude;
  final double locationLongitude;
  final String locationName;

  SystemEntity toEntity() => SystemEntity(
      id: id,
      pointReference: pointReference,
      timeReference: timeReference,
      maxBookingQuota: maxBookingQuota,
      status: status,
      inputBy: inputBy,
      inputDate: inputDate,
      locationLatitude: locationLatitude,
      locationLongitude: locationLongitude,
      locationName: locationName);

  SystemModel({
    required this.id,
    required this.pointReference,
    required this.timeReference,
    required this.maxBookingQuota,
    required this.status,
    required this.inputBy,
    required this.inputDate,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.locationName,
  });

  factory SystemModel.fromJson(Map<String, dynamic> json) => SystemModel(
        id: json['_id'],
        pointReference: json['point_reference'],
        timeReference: json['time_reference'],
        maxBookingQuota: json['max_booking_quota'],
        status: json['status'],
        inputBy: json['input_by'],
        inputDate: DateTime.parse(json['input_date']),
        locationLatitude: json['location_latitude'].toDouble(),
        locationLongitude: json['location_longitude'].toDouble(),
        locationName: json['location_name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'point_reference': pointReference,
        'time_reference': timeReference,
        'max_booking_quota': maxBookingQuota,
        'status': status,
        'input_by': inputBy,
        'input_date': inputDate.toIso8601String(),
        'location_latitude': locationLatitude,
        'location_longitude': locationLongitude,
        'location_name': locationName,
      };

  static List<SystemModel> systemModelFromJson(List<dynamic> data) =>
      List<SystemModel>.from(data.map((x) => SystemModel.fromJson(x)));

  static String systemModelToJson(List<SystemModel> data) =>
      json.encode(data.map((x) => x.toJson()).toList());
}
