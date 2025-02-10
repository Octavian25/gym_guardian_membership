import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/bloc/body_measurement_bloc/body_measurement_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/ruler_picker_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class WeightRegisterBodymeasurement extends StatefulWidget {
  const WeightRegisterBodymeasurement({super.key});

  @override
  State<WeightRegisterBodymeasurement> createState() => _WeightRegisterBodymeasurementState();
}

class _WeightRegisterBodymeasurementState extends State<WeightRegisterBodymeasurement> {
  ValueNotifier<double> weightNotifier = ValueNotifier(50);
  double result = 0;
  String ibmCategory = "(Normal)";
  Color color = Colors.green;
  void storeWeight() {
    var currentState = context.read<BodyMeasurementBloc>().state;
    if (currentState is BodyMeasurementSuccess) {
      context.read<BodyMeasurementBloc>().add(DoBodyMeasurement(currentState.datas.copyWith(
            weight: weightNotifier.value,
            bmi: result,
          )));
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(
          100.milliseconds,
          () {
            if (!mounted) return;
            var memberState = context.read<DetailMemberBloc>().state;
            var currentState = context.read<BodyMeasurementBloc>().state;
            if (currentState is BodyMeasurementSuccess) {
              if (memberState is DetailMemberSuccess) {
                weightNotifier.value = memberState.datas.weight.toDouble();
                result = calculateBMI(
                    memberState.datas.weight.toDouble(), currentState.datas.height!.toDouble());
                ibmCategory = getBMICategory(memberState.datas.gender, result, context);
                color = getBMIColor(memberState.datas.gender, result);
                setState(() {});
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            20.verticalSpacingRadius,
            SizedBox(
              width: 0.7.sw,
              child: Text(
                context.l10n.hows_your_weight,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.bold),
              ),
            ),
            20.verticalSpacingRadius,
            ValueListenableBuilder<double>(
              valueListenable: weightNotifier,
              builder: (context, value, child) => Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value.toString(),
                      style: bebasNeue.copyWith(fontSize: 80.spMin),
                    ),
                    Text(
                      "kg",
                      style: bebasNeue.copyWith(fontSize: 30.spMin),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: weightNotifier,
              builder: (context, value, child) {
                return LayoutBuilder(
                  builder: (context, constraints) => SimpleRulerPicker(
                    selectedTextStyle: bebasNeue.copyWith(fontSize: 50.spMin),
                    initialValue: (value * 10).ceil(),
                    minValue: 0,
                    maxValue: 1000,
                    scaleItemWidth: 11,
                    showSelectedText: false,
                    isDecimal: true,
                    onValueChanged: (value) {
                      weightNotifier.value = value;
                      storeWeight();
                    },
                  ),
                );
              },
            ),
            20.verticalSpacingRadius,
            BlocBuilder<BodyMeasurementBloc, BodyMeasurementState>(
              builder: (context, state) {
                if (state is BodyMeasurementSuccess) {
                  var memberState = context.read<DetailMemberBloc>().state;
                  if (memberState is DetailMemberSuccess) {
                    result =
                        calculateBMI(weightNotifier.value, (state.datas.height ?? 0).toDouble());
                    ibmCategory = getBMICategory(memberState.datas.gender, result, context);
                    color = getBMIColor(memberState.datas.gender, result);
                  }
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: Colors.grey.shade100),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.l10n.your_bmi,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            5.horizontalSpaceRadius,
                            Text(
                              ibmCategory,
                              style: TextStyle(fontWeight: FontWeight.bold, color: color),
                            )
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Text(
                              result.toString(),
                              style: bebasNeue.copyWith(fontSize: 30.spMin, color: color),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            20.verticalSpacingRadius,
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: PrimaryButtonIcon(
                    color: onPrimaryColor,
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.go("/register-body-measurements-tracker/height");
                    },
                  ),
                ),
                5.horizontalSpaceRadius,
                Expanded(
                  flex: 4,
                  child: PrimaryButton(
                    title: context.l10n.next,
                    onPressed: () {
                      var currentState = context.read<BodyMeasurementBloc>().state;
                      if (currentState is BodyMeasurementSuccess) {
                        context.read<BodyMeasurementBloc>().add(DoBodyMeasurement(currentState.datas
                            .copyWith(weight: weightNotifier.value, bmi: result)));
                      }
                      context.go("/register-body-measurements-tracker/chest-circumference");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

double calculateBMI(double weight, double height) {
  if (height <= 0 || weight <= 0) {
    throw ArgumentError("Weight and height must be greater than zero.");
  }

  // Konversi tinggi dari cm ke meter
  double heightInMeters = height / 100;

  // Rumus BMI: Berat (kg) / (Tinggi (m) * Tinggi (m))
  double bmi = weight / (heightInMeters * heightInMeters);

  return double.parse(bmi.toStringAsFixed(2)); // Dibulatkan ke 2 desimal
}

String getBMICategory(String gender, double bmi, BuildContext context) {
  if (gender.toLowerCase() == "pria") {
    if (bmi < 18.5) {
      return "(${context.l10n.skinny})";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "(${context.l10n.healty})";
    } else if (bmi >= 25 && bmi < 29.9) {
      return "(${context.l10n.over_weight})";
    } else if (bmi >= 30 && bmi < 34.9) {
      return "(${context.l10n.mild_obesity})";
    } else if (bmi >= 35 && bmi < 39.9) {
      return "(${context.l10n.moderate_obesity})";
    } else {
      return "(${context.l10n.morbid_obesity})";
    }
  } else if (gender.toLowerCase() == "wanita") {
    if (bmi < 18.5) {
      return "(${context.l10n.skinny})";
    } else if (bmi >= 18.5 && bmi < 23.9) {
      return "(${context.l10n.healty})";
    } else if (bmi >= 24 && bmi < 28.9) {
      return "(${context.l10n.over_weight})";
    } else if (bmi >= 29 && bmi < 34.9) {
      return "(${context.l10n.mild_obesity})";
    } else if (bmi >= 35 && bmi < 39.9) {
      return "(${context.l10n.moderate_obesity})";
    } else {
      return "(${context.l10n.morbid_obesity})";
    }
  } else {
    return "Gender tidak valid";
  }
}

Color getBMIColor(String gender, double bmi) {
  if (gender.toLowerCase() == "pria") {
    if (bmi < 18.5) {
      return Colors.blue; // Underweight - Biru (Kurang berat)
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return Colors.green; // Normal - Hijau (Sehat)
    } else if (bmi >= 25 && bmi < 29.9) {
      return Colors.orange; // Overweight - Oranye (Kelebihan Berat)
    } else if (bmi >= 30 && bmi < 34.9) {
      return Colors.red; // Obesity Class 1 - Merah (Obesitas Ringan)
    } else if (bmi >= 35 && bmi < 39.9) {
      return Colors.deepOrange; // Obesity Class 2 - Merah Tua (Obesitas Sedang)
    } else {
      return Colors.purple; // Obesity Class 3 - Ungu (Obesitas Berat)
    }
  } else if (gender.toLowerCase() == "wanita") {
    if (bmi < 18.5) {
      return Colors.blue; // Underweight - Biru (Kurang berat)
    } else if (bmi >= 18.5 && bmi < 23.9) {
      return Colors.green; // Normal - Hijau (Sehat)
    } else if (bmi >= 24 && bmi < 28.9) {
      return Colors.orange; // Overweight - Oranye (Kelebihan Berat)
    } else if (bmi >= 29 && bmi < 34.9) {
      return Colors.red; // Obesity Class 1 - Merah (Obesitas Ringan)
    } else if (bmi >= 35 && bmi < 39.9) {
      return Colors.deepOrange; // Obesity Class 2 - Merah Tua (Obesitas Sedang)
    } else {
      return Colors.purple; // Obesity Class 3 - Ungu (Obesitas Berat)
    }
  } else {
    return Colors.grey; // Default jika gender tidak valid
  }
}
