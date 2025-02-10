import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/ruler_picker_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class CircumferenceCard extends StatelessWidget {
  const CircumferenceCard(
      {super.key, required this.title, required this.value, required this.type});
  final String title;
  final double value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: onPrimaryColor.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), spreadRadius: 0.5, blurRadius: 10)
          ]),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.bold),
          ),
          5.verticalSpacingRadius,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedNumberText(
                value,
                duration: 1.seconds,
                formatter: (value) => value.toStringAsFixed(2),
                maxLines: 1,
                style: bebasNeue.copyWith(fontSize: 50.spMin),
              ),
              5.horizontalSpaceRadius,
              Text(
                type,
                style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SimpleRulerPicker(
                height: 58.h,
                key: ValueKey(value.floor()),
                initialValue: value.floor(),
                showSelectedText: false,
                enabled: false,
              );
            },
          )
        ],
      ),
    );
  }
}
