// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

import 'package:gym_guardian_membership/register/domain/entities/member_entity.dart';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
  final String memberCode;
  final String memberName;
  final String memberEmail;
  final String packageCode;
  final String packageName;
  final String noHandphone;
  final int price;
  final int point;
  final String fingerprint;
  final String ifid;
  final String expiredDate;
  final String password;
  final bool status;
  final bool onSite;
  final bool loginStatus;
  final String level;
  final String inputBy;
  final DateTime inputDate;

  MemberModel({
    required this.memberCode,
    required this.memberName,
    required this.memberEmail,
    required this.packageCode,
    required this.packageName,
    required this.noHandphone,
    required this.price,
    required this.point,
    required this.fingerprint,
    required this.ifid,
    required this.expiredDate,
    required this.password,
    required this.status,
    required this.onSite,
    required this.loginStatus,
    required this.level,
    required this.inputBy,
    required this.inputDate,
  });

  MemberEntity toEntity() => MemberEntity(
      memberCode: memberCode,
      memberName: memberName,
      memberEmail: memberEmail,
      packageCode: packageCode,
      packageName: packageName,
      noHandphone: noHandphone,
      price: price,
      point: point,
      fingerprint: fingerprint,
      ifid: ifid,
      expiredDate: expiredDate,
      password: password,
      status: status,
      onSite: onSite,
      loginStatus: loginStatus,
      level: level,
      inputBy: inputBy,
      inputDate: inputDate);
  MemberModel copyWith({
    String? memberCode,
    String? memberName,
    String? memberEmail,
    String? packageCode,
    String? packageName,
    String? noHandphone,
    int? price,
    int? point,
    String? fingerprint,
    String? ifid,
    String? expiredDate,
    String? password,
    bool? status,
    bool? onSite,
    bool? loginStatus,
    String? level,
    String? inputBy,
    DateTime? inputDate,
  }) =>
      MemberModel(
        memberCode: memberCode ?? this.memberCode,
        memberName: memberName ?? this.memberName,
        memberEmail: memberEmail ?? this.memberEmail,
        packageCode: packageCode ?? this.packageCode,
        packageName: packageName ?? this.packageName,
        noHandphone: noHandphone ?? this.noHandphone,
        price: price ?? this.price,
        point: point ?? this.point,
        fingerprint: fingerprint ?? this.fingerprint,
        ifid: ifid ?? this.ifid,
        expiredDate: expiredDate ?? this.expiredDate,
        password: password ?? this.password,
        status: status ?? this.status,
        onSite: onSite ?? this.onSite,
        loginStatus: loginStatus ?? this.loginStatus,
        level: level ?? this.level,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
      );

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        memberCode: json["member_code"],
        memberName: json["member_name"],
        memberEmail: json["member_email"],
        packageCode: json["package_code"],
        packageName: json["package_name"],
        noHandphone: json["no_handphone"],
        price: json["price"],
        point: json["point"],
        fingerprint: "-",
        ifid: json["ifid"],
        expiredDate: json["expired_date"],
        password: json["password"],
        status: json["status"],
        onSite: json["on_site"],
        loginStatus: json["login_status"],
        level: json["level"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]),
      );

  Map<String, dynamic> toJson() => {
        "member_code": memberCode,
        "member_name": memberName,
        "member_email": memberEmail,
        "package_code": packageCode,
        "package_name": packageName,
        "no_handphone": noHandphone,
        "price": price,
        "point": point,
        "fingerprint": fingerprint,
        "ifid": ifid,
        "expired_date": expiredDate,
        "password": password,
        "status": status,
        "on_site": onSite,
        "login_status": loginStatus,
        "level": level,
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
      };
}
