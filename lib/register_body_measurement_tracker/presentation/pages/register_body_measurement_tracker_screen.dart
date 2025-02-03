import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class RegisterBodyMeasurementTracker extends StatefulWidget {
  final Widget body;
  final int currentIndex;
  const RegisterBodyMeasurementTracker({super.key, required this.body, required this.currentIndex});

  @override
  State<RegisterBodyMeasurementTracker> createState() => _RegisterBodyMeasurementTrackerState();
}

class _RegisterBodyMeasurementTrackerState extends State<RegisterBodyMeasurementTracker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        forceMaterialTransparency: true,
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 15,
              children: [
                Text(
                  widget.currentIndex.toString().padLeft(2, "0"),
                  style: TextStyle(
                      fontSize: 13.spMin, fontWeight: FontWeight.bold, color: primaryColor),
                ),
                Text(
                  "BODY MEASUREMENT",
                  style: TextStyle(fontSize: 13.spMin),
                ),
              ],
            ),
            3.verticalSpacingRadius,
            SizedBox(
              width: 0.5.sw,
              child: Row(
                children: [
                  Expanded(
                      child: LinearProgressIndicator(
                    value: (widget.currentIndex) / 7,
                  ))
                ],
              ),
            )
          ],
        ),
      ),
      body: widget.body,
    );
  }
}
