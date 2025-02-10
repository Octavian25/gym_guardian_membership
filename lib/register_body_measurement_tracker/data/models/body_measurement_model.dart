import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';

List<BodyMeasurementModel> bodyMeasurementModelFromJson(List<dynamic> data) =>
    List<BodyMeasurementModel>.from(data.map((e) => BodyMeasurementModel.fromJson(e)));

class BodyMeasurementModel {
  String? memberCode;
  double? weight;
  int? height;
  int? chestCircumference;
  int? waistCircumference;
  int? thighCircumference;
  int? armCircumference;
  int? bodyFatPercentage;
  double? bmi;
  DateTime? inputDate;

  BodyMeasurementEntity toEntity() => BodyMeasurementEntity(
      memberCode: memberCode,
      weight: weight,
      height: height,
      chestCircumference: chestCircumference,
      waistCircumference: waistCircumference,
      armCircumference: armCircumference,
      bodyFatPercentage: bodyFatPercentage,
      bmi: bmi,
      inputDate: inputDate,
      thighCircumference: thighCircumference);

  BodyMeasurementModel(
      {this.memberCode,
      this.weight,
      this.height,
      this.chestCircumference,
      this.waistCircumference,
      this.armCircumference,
      this.bodyFatPercentage,
      this.bmi,
      this.inputDate,
      this.thighCircumference});

  BodyMeasurementModel copyWith({
    String? memberCode,
    double? weight,
    int? height,
    int? chestCircumference,
    int? waistCircumference,
    int? thighCircumference,
    int? armCircumference,
    int? bodyFatPercentage,
    double? bmi,
    DateTime? inputDate,
  }) {
    return BodyMeasurementModel(
      memberCode: memberCode ?? this.memberCode,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      chestCircumference: chestCircumference ?? this.chestCircumference,
      waistCircumference: waistCircumference ?? this.waistCircumference,
      thighCircumference: thighCircumference ?? this.thighCircumference,
      armCircumference: armCircumference ?? this.armCircumference,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      bmi: bmi ?? this.bmi,
      inputDate: inputDate ?? this.inputDate,
    );
  }

  factory BodyMeasurementModel.fromJson(Map<String, dynamic> json) => BodyMeasurementModel(
        bmi: json['bmi'],
        armCircumference: json['armCircumference'],
        bodyFatPercentage: json['bodyFatPercentage'],
        chestCircumference: json['chestCircumference'],
        height: json['height'],
        memberCode: json['member_code'],
        thighCircumference: json['thighCircumference'],
        waistCircumference: json['waistCircumference'],
        weight: json['weight']?.toDouble() ?? 0.0,
        inputDate: DateTime.parse(json['input_date']),
      );

  Map<String, dynamic> toJson() => {
        'member_code': memberCode,
        'weight': weight,
        'height': height,
        'chestCircumference': chestCircumference,
        'waistCircumference': waistCircumference,
        'thighCircumference': thighCircumference,
        'armCircumference': armCircumference,
        'bodyFatPercentage': bodyFatPercentage,
        'bmi': bmi,
      };
}
