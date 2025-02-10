import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/bloc/fetch_body_measurement_bloc/fetch_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/bloc/register_body_measurement_bloc/register_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/show_bottom_dialog.dart';
import 'package:os_basecode/os_basecode.dart';

class RegisterBodyMeasurementTracker extends StatefulWidget {
  final Widget body;
  final int currentIndex;
  final String? fallbackURL;
  const RegisterBodyMeasurementTracker(
      {super.key, required this.body, required this.currentIndex, this.fallbackURL});

  @override
  State<RegisterBodyMeasurementTracker> createState() => _RegisterBodyMeasurementTrackerState();
}

class _RegisterBodyMeasurementTrackerState extends State<RegisterBodyMeasurementTracker> {
  @override
  void initState() {
    super.initState();
    Animate.restartOnHotReload = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBodyMeasurementBloc, RegisterBodyMeasurementState>(
      listener: (context, state) {
        if (state is RegisterBodyMeasurementSuccess) {
          var memberState = getMemberEntityFromBloc(context);
          if (memberState != null) {
            context.read<FetchBodyMeasurementBloc>().add(DoFetchBodyMeasurement(
                  memberState.memberCode,
                ));
          }
          showBottomDialogueAlert(
            imagePath: "assets/congrats.png",
            title: context.l10n.body_measurement_success,
            subtitle: context.l10n.body_measurement_success_subtitle,
            duration: 3,
            onTimerComplete: () {
              context.go("/body-measurements-tracker");
            },
          );
        } else if (state is RegisterBodyMeasurementFailure) {
          showBottomDialogueAlert(
              imagePath: "assets/sad.png",
              title: context.l10n.body_measurement_failed,
              subtitle: context.l10n.body_measurement_failed_subtitle,
              duration: 2);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          centerTitle: true,
          actions: [
            IconButton.filled(
                color: Colors.white,
                style: IconButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  if (widget.fallbackURL != null) {
                    context.go("/body-measurements-tracker");
                    return;
                  }
                  context.go('/body-measurements-tracker');
                },
                icon: Icon(
                  Icons.exit_to_app_rounded,
                )),
            10.horizontalSpaceRadius
          ],
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
                    context.l10n.body_measurement,
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
      ),
    );
  }
}
