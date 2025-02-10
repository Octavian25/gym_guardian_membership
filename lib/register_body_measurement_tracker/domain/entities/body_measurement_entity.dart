import 'package:gym_guardian_membership/register_body_measurement_tracker/data/models/body_measurement_model.dart';
import 'package:os_basecode/os_basecode.dart';

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
  DateTime? inputDate;

  BodyMeasurementModel toModel() => BodyMeasurementModel(
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

  BodyMeasurementEntity(
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

  Map<String, dynamic> toJson() => {
        'weight': weight,
        'height': height,
        'chestCircumference': chestCircumference,
        'waistCircumference': waistCircumference,
        'thighCircumference': thighCircumference,
        'armCircumference': armCircumference,
        'bodyFatPercentage': bodyFatPercentage,
        'bmi': bmi,
        'inputDate': inputDate?.toIso8601String(), // Handle null inputDate
      };

  String toGeminiPrompt() {
    if (inputDate == null) {
      return "No body measurement data available.";
    }

    final formattedDate = DateFormat('d MMMM yyyy', 'id').format(inputDate!); // Format date

    return "Tanggal $formattedDate: Berat $weight kg, Tinggi $height cm, Lingkar Dada $chestCircumference cm, Lingkar Pinggang $waistCircumference cm, Lingkar Paha $thighCircumference cm, Lingkar Lengan $armCircumference cm, Persentase Lemak Tubuh $bodyFatPercentage%, BMI $bmi";
  }

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
    DateTime? inputDate,
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
      inputDate: inputDate ?? this.inputDate,
    );
  }
}
