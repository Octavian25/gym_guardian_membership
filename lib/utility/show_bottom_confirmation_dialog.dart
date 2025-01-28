import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';

Future<void> showBottomConfirmationDialogueAlert(
    {required String imagePath,
    required String title,
    required String subtitle,
    required Function(BuildContext context) handleConfirm,
    BuildContext? buildContext}) async {
  return showBlurredBottomSheet(
    context: buildContext ?? parentKey.currentContext!,
    builder: (context) {
      return BlurContainerWrapper(
        child: ShowBottomDialogueAlert(
          imagePath: imagePath,
          title: title,
          subtitle: subtitle,
          handleConfirm: handleConfirm,
        ),
      );
    },
  );
}

class ShowBottomDialogueAlert extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final Function(BuildContext context) handleConfirm;
  const ShowBottomDialogueAlert(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.handleConfirm});

  @override
  State<ShowBottomDialogueAlert> createState() => _ShowBottomDialogueAlertState();
}

class _ShowBottomDialogueAlertState extends State<ShowBottomDialogueAlert>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
          PrimaryButton(
              title: "OK",
              onPressed: () {
                widget.handleConfirm(context);
              }),
          10.verticalSpacingRadius,
        ],
      ),
    );
  }
}
