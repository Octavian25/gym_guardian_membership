import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class WelcomePageRegisterBodymeasurement extends StatefulWidget {
  const WelcomePageRegisterBodymeasurement({super.key});

  @override
  State<WelcomePageRegisterBodymeasurement> createState() =>
      _WelcomePageRegisterBodymeasurementState();
}

class _WelcomePageRegisterBodymeasurementState extends State<WelcomePageRegisterBodymeasurement> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(
          1700.milliseconds,
          () {
            if (!mounted) return;
            context.go("/body-metrics/register-body-measurements-tracker/height");
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
              child: Center(
                child: Text(
                  "Body Measurement",
                  style: bebasNeue.copyWith(fontSize: 50.spMin),
                ),
              ))
          .animate()
          .slideY(begin: 0.03, end: 0, duration: 600.milliseconds, curve: Curves.ease)
          .fadeIn(duration: 800.milliseconds, curve: Curves.ease)
          .then(delay: 200.milliseconds)
          .fadeOut(curve: Curves.ease),
    );
  }
}
