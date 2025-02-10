import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class UpdateMeasurementButton extends StatelessWidget {
  final String lastUpdate;
  const UpdateMeasurementButton({super.key, required this.lastUpdate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/register-body-measurements-tracker", extra: "/body-measurements-tracker");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: onPrimaryColor.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1), spreadRadius: 0.5, blurRadius: 10)
            ]),
        child: Row(
          children: [
            Icon(
              Icons.info_rounded,
              color: primaryColor,
            ),
            20.horizontalSpaceRadius,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.update_measurement,
                  style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.bold),
                ),
                Text(
                  lastUpdate,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.spMin),
                ),
              ],
            )),
            Icon(
              Icons.chevron_right_rounded,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
