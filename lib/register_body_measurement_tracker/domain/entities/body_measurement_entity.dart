import 'package:gym_guardian_membership/register_body_measurement_tracker/data/models/body_measurement_model.dart';

class BodyMeasurementEntity {
  String? memberCode;
  double? weight;
  int? height;
  int? chestCircumference;
  int? waistCircumference;
  int? thighCircumference;
  int? armCircumference;
  int? bodyFatPercentage;
  double? bmi;

  BodyMeasurementModel toModel() => BodyMeasurementModel(
      memberCode: memberCode,
      weight: weight,
      height: height,
      chestCircumference: chestCircumference,
      waistCircumference: waistCircumference,
      armCircumference: armCircumference,
      bodyFatPercentage: bodyFatPercentage,
      bmi: bmi,
      thighCircumference: thighCircumference);

  BodyMeasurementEntity(
      {this.memberCode,
      this.weight,
      this.height,
      this.chestCircumference,
      this.waistCircumference,
      this.armCircumference,
      this.bodyFatPercentage,
      this.bmi,
      this.thighCircumference});

  BodyMeasurementEntity copyWith({
    String? memberCode,
    double? weight,
    int? height,
    int? chestCircumference,
    int? waistCircumference,
    int? thighCircumference,
    int? armCircumference,
    int? bodyFatPercentage,
    double? bmi,
  }) {
    return BodyMeasurementEntity(
      memberCode: memberCode ?? this.memberCode,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      chestCircumference: chestCircumference ?? this.chestCircumference,
      waistCircumference: waistCircumference ?? this.waistCircumference,
      thighCircumference: thighCircumference ?? this.thighCircumference,
      armCircumference: armCircumference ?? this.armCircumference,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      bmi: bmi ?? this.bmi,
    );
  }
}
