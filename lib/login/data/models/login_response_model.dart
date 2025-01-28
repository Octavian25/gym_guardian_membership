import 'dart:convert';

import 'package:gym_guardian_membership/login/domain/entities/login_response_entity.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final String level;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.level,
  });

  LoginResponseEntity toEntity() => LoginResponseEntity(
      accessToken: accessToken, refreshToken: refreshToken, userId: userId, level: level);

  LoginResponseModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? userId,
    String? level,
  }) =>
      LoginResponseModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        userId: userId ?? this.userId,
        level: level ?? this.level,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
