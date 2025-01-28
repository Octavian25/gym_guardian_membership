import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';

Future<void> showBottomDialogueAlert(
    {required String imagePath,
    required String title,
    required String subtitle,
    required int duration,
    BuildContext? buildContext}) async {
  return showBlurredBottomSheet(
    context: buildContext ?? parentKey.currentContext!,
    builder: (context) {
      return BlurContainerWrapper(
        child: ShowBottomDialogueAlert(
          imagePath: imagePath,
          title: title,
          subtitle: subtitle,
          duration: duration,
        ),
      );
    },
  );
}

class ShowBottomDialogueAlert extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final int duration;
  const ShowBottomDialogueAlert(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.duration});

  @override
  State<ShowBottomDialogueAlert> createState() => _ShowBottomDialogueAlertState();
}

class _ShowBottomDialogueAlertState extends State<ShowBottomDialogueAlert>
    with SingleTickerProviderStateMixin {
  int countdown = 3;
  @override
  void initState() {
    super.initState();
    countdown = widget.duration;
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Timer.periodic(
          1.seconds,
          (timer) {
            if (countdown == 1) {
              timer.cancel();
              context.pop();
            }
            setState(() {
              countdown--;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              widget.imagePath,
              width: 0.35.sw,
            ),
          ),
          10.verticalSpacingRadius,
          Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.spMin, color: Colors.black54),
            ),
          ),
          20.verticalSpacingRadius,
          Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 25.h,
                  height: 25.h,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1, end: 0),
                    duration: Duration(seconds: countdown),
                    builder: (context, value, _) => CircularProgressIndicator(
                      value: value,
                      strokeWidth: 5.h,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 25.h,
                  height: 25.h,
                  child: Center(
                    child: Text(
                      "$countdown",
                      style: bebasNeue.copyWith(fontSize: 16.spMin, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpacingRadius,
        ],
      ),
    );
  }
}
