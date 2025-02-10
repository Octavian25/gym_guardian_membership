import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';

Future<void> showBottomConfirmationDialogueAlert(
    {required String imagePath,
    required String title,
    required String subtitle,
    required Function(BuildContext context) handleConfirm,
    BuildContext? buildContext,
    bool? showSecondaryButton,
    Function(BuildContext context)? handleCancel,
    String? buttonText,
    String? secondaryButtonText}) async {
  return showBlurredBottomSheet(
    context: buildContext ?? parentKey.currentContext!,
    builder: (context) {
      return BlurContainerWrapper(
        child: ShowBottomDialogueAlert(
            imagePath: imagePath,
            title: title,
            subtitle: subtitle,
            handleConfirm: handleConfirm,
            showSecondaryButton: showSecondaryButton ?? false,
            handleCancel: handleCancel,
            secondaryButtonText: secondaryButtonText,
            buttonText: buttonText),
      );
    },
  );
}

class ShowBottomDialogueAlert extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String? buttonText;
  final String? secondaryButtonText;
  final bool showSecondaryButton;
  final Function(BuildContext context) handleConfirm;
  final Function(BuildContext context)? handleCancel;
  const ShowBottomDialogueAlert(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      this.showSecondaryButton = false,
      this.handleCancel,
      this.secondaryButtonText,
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
    return SafeArea(
      child: Padding(
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
            5.verticalSpacingRadius,
            Center(
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.spMin, color: Colors.black54),
              ),
            ),
            20.verticalSpacingRadius,
            PrimaryButton(
                title: widget.buttonText ?? "OK",
                onPressed: () {
                  widget.handleConfirm(context);
                }),
            if (widget.showSecondaryButton) 5.verticalSpacingRadius,
            if (widget.showSecondaryButton)
              Center(
                child: TextButton(
                  onPressed: () {
                    if (widget.handleCancel != null) {
                      widget.handleCancel!(context);
                    }
                  },
                  child: Text(
                    widget.secondaryButtonText ?? "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
