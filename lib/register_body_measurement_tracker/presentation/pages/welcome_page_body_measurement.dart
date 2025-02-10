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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.5,
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Body Measurement",
                              style: bebasNeue.copyWith(fontSize: 50.spMin),
                            )
                                .animate(delay: 200.milliseconds)
                                .slideY(
                                    begin: -0.2,
                                    end: 0,
                                    duration: 600.milliseconds,
                                    curve: Curves.ease)
                                .fadeIn(duration: 800.milliseconds, curve: Curves.ease)
                                .then(delay: 200.milliseconds)
                                .slideY(
                                    begin: 0.1,
                                    end: -1,
                                    duration: 600.milliseconds,
                                    curve: Curves.ease)
                                .fadeOut(duration: 300.milliseconds, curve: Curves.ease),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: constraints.maxHeight * 0.5,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 7,
                          color: Colors.black,
                          width: 0.5.sw,
                        )
                            .animate(delay: 200.milliseconds)
                            .slideY(begin: 0.1, duration: 600.milliseconds, curve: Curves.ease)
                            .fadeIn(duration: 800.milliseconds, curve: Curves.ease)
                            .then(delay: 200.milliseconds)
                            .slideY(
                                begin: 0.1,
                                end: 2,
                                duration: 600.milliseconds,
                                curve: Curves.fastEaseInToSlowEaseOut)
                            .then()
                            .slideX(end: 5, curve: Curves.ease, duration: 300.milliseconds)
                            .callback(
                          callback: (value) {
                            context.go("/register-body-measurements-tracker/height");
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            )));
  }
}
