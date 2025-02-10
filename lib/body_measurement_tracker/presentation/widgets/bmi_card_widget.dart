import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/widgets/bmi_line_chart_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/weight_page.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class CardBMIWidget extends StatelessWidget {
  final List<BodyMeasurementEntity> listData;
  final BodyMeasurementEntity? lastData;
  final int selectedIndex;
  const CardBMIWidget({super.key, required this.listData, this.lastData, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMemberBloc, DetailMemberState>(
      builder: (context, state) {
        if (state is DetailMemberSuccess) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: onPrimaryColor.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1), spreadRadius: 0.5, blurRadius: 10)
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BMILineChart(listData: listData, selectedIndex: selectedIndex),
                10.verticalSpacingRadius,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedNumberText(
                      lastData?.bmi ?? 0,
                      duration: 1.seconds,
                      formatter: (value) => value.toStringAsFixed(2),
                      maxLines: 1,
                      style: bebasNeue.copyWith(fontSize: 40.spMin),
                    ),
                    5.horizontalSpaceRadius,
                    Text(
                      getBMICategory(state.datas.gender, lastData?.bmi ?? 0, context),
                      style: TextStyle(
                          fontSize: 14.spMin,
                          color: colorBMI(state.datas.gender, lastData?.bmi ?? 0),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                10.verticalSpacingRadius,
                Text(
                  context.l10n.last_bmi_value,
                  style: TextStyle(fontSize: 13.spMin),
                ),
                10.verticalSpacingRadius,
                LayoutBuilder(
                  builder: (context, constraints) {
                    var blocWidth = constraints.maxWidth / 25;
                    return SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 25,
                        itemBuilder: (context, index) {
                          const whitelistText = [15, 18, 25, 30, 40];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: colorBMI(state.datas.gender, (index + 15).toDouble()),
                                    borderRadius: BorderRadius.circular(3)),
                                width: (blocWidth * 0.6),
                                height: 24,
                                margin: EdgeInsets.only(right: (blocWidth * 0.4)),
                              ),
                              Spacer(),
                              if (whitelistText.contains(index + 15))
                                Text(
                                  (index + 15).toString(),
                                  style: TextStyle(fontSize: 9.spMin),
                                )
                            ],
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

Color colorBMI(String gender, double index) {
  if (gender.toLowerCase() == "pria") {
    if (index < 18.5) {
      return Colors.blue; // Underweight - Biru (Kurang berat)
    } else if (index >= 18.5 && index < 24.9) {
      return Colors.green; // Normal - Hijau (Sehat)
    } else if (index >= 25 && index < 29.9) {
      return Colors.orange; // Overweight - Oranye (Kelebihan Berat)
    } else if (index >= 30 && index < 34.9) {
      return Colors.red; // Obesity Class 1 - Merah (Obesitas Ringan)
    } else if (index >= 35 && index < 39.9) {
      return Colors.deepOrange; // Obesity Class 2 - Merah Tua (Obesitas Sedang)
    } else {
      return Colors.purple; // Obesity Class 3 - Ungu (Obesitas Berat)
    }
  } else if (gender.toLowerCase() == "wanita") {
    if (index < 18.5) {
      return Colors.blue; // Underweight - Biru (Kurang berat)
    } else if (index >= 18.5 && index < 23.9) {
      return Colors.green; // Normal - Hijau (Sehat)
    } else if (index >= 24 && index < 28.9) {
      return Colors.orange; // Overweight - Oranye (Kelebihan Berat)
    } else if (index >= 29 && index < 34.9) {
      return Colors.red; // Obesity Class 1 - Merah (Obesitas Ringan)
    } else if (index >= 35 && index < 39.9) {
      return Colors.deepOrange; // Obesity Class 2 - Merah Tua (Obesitas Sedang)
    } else {
      return Colors.purple; // Obesity Class 3 - Ungu (Obesitas Berat)
    }
  } else {
    return Colors.grey; // Default jika gender tidak valid
  }
}
