// To parse this JSON data, do
//
//     final loginResponseEntity = loginResponseEntityFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/login/data/models/login_response_model.dart';

LoginResponseEntity loginResponseEntityFromJson(String str) =>
    LoginResponseEntity.fromJson(json.decode(str));

String loginResponseEntityToJson(LoginResponseEntity data) => json.encode(data.toJson());

class LoginResponseEntity {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final String level;

  LoginResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.level,
  });

  LoginResponseModel toModel() => LoginResponseModel(
      accessToken: accessToken, refreshToken: refreshToken, userId: userId, level: level);

  LoginResponseEntity copyWith({
    String? accessToken,
    String? refreshToken,
    String? userId,
    String? level,
  }) =>
      LoginResponseEntity(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        userId: userId ?? this.userId,
        level: level ?? this.level,
      );

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) => LoginResponseEntity(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        userId: json["user_id"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "user_id": userId,
        "level": level,
      };
}
