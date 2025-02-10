import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/bloc/body_measurement_bloc/body_measurement_bloc.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/bloc/register_body_measurement_bloc/register_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/widgets/notification_interval_widget.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/widgets/notification_time_widget.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/notification_handler.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:gym_guardian_membership/utility/ruler_picker_widget.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:gym_guardian_membership/utility/show_bottom_dialog.dart';
import 'package:os_basecode/os_basecode.dart';

class BodyFatRegisterBodymeasurement extends StatefulWidget {
  const BodyFatRegisterBodymeasurement({super.key});

  @override
  State<BodyFatRegisterBodymeasurement> createState() => _BodyFatRegisterBodymeasurementState();
}

class _BodyFatRegisterBodymeasurementState extends State<BodyFatRegisterBodymeasurement> {
  ValueNotifier<int> bodyFatNotifier = ValueNotifier(10);
  final NotificationHandler notificationHandler = NotificationHandler();

  void handleRegisterBodyMeasurement() async {
    await showBlurredBottomSheet(
      context: parentKey.currentContext!,
      builder: (context) {
        return BlurContainerWrapper(
          child: AskNotificationWidget(bodyFatNotifier: bodyFatNotifier),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            20.verticalSpacingRadius,
            SizedBox(
              width: 0.7.sw,
              child: Text(
                context.l10n.hows_your_body_fat,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.bold),
              ),
            ),
            20.verticalSpacingRadius,
            Expanded(
              child: Stack(
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: bodyFatNotifier,
                    builder: (context, value, child) => Center(
                        child: Transform.translate(
                      offset: Offset(0, -(70.spMin / 2)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            value.toString(),
                            style: bebasNeue.copyWith(fontSize: 70.spMin, height: 0.9),
                          ),
                          Text(
                            "%",
                            style: bebasNeue.copyWith(fontSize: 20.spMin),
                          ),
                        ],
                      ),
                    )),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            primaryColor,
                            primaryColor,
                            Colors.transparent
                          ],
                          stops: const [
                            0.0,
                            0.2,
                            0.8,
                            1.0
                          ]).createShader(bounds);
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) => SimpleRulerPicker(
                        axis: Axis.vertical,
                        selectedTextStyle: bebasNeue.copyWith(fontSize: 50.spMin),
                        initialValue: 10,
                        height: constraints.maxHeight,
                        maxValue: 100,
                        scaleItemWidth: 15,
                        showSelectedText: true,
                        showBottomText: false,
                        horizontalPointerWidth: constraints.maxWidth * 0.6,
                        onValueChanged: (value) {
                          bodyFatNotifier.value = value.ceil();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpacingRadius,
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: PrimaryButtonIcon(
                    color: onPrimaryColor,
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.go("/register-body-measurements-tracker/arm-circumference");
                    },
                  ),
                ),
                5.horizontalSpaceRadius,
                Flexible(
                  flex: 4,
                  child: PrimaryButton(
                    title: context.l10n.finish,
                    onPressed: handleRegisterBodyMeasurement,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AskNotificationWidget extends StatelessWidget {
  final ValueNotifier<int> bodyFatNotifier;
  const AskNotificationWidget({super.key, required this.bodyFatNotifier});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              "assets/notification.png",
              width: 0.3.sw,
            ),
            10.verticalSpacingRadius,
            Center(
              child: Text(
                context.l10n.create_reminder,
                style: bebasNeue.copyWith(fontSize: 25.spMin),
              ),
            ),
            5.verticalSpacingRadius,
            Text(
              context.l10n.create_reminder_subtitle,
              textAlign: TextAlign.center,
            ),
            20.verticalSpacingRadius,
            PrimaryButton(
              title: context.l10n.activate,
              onPressed: () async {
                int? intervalDay = await showBlurredBottomSheet<int>(
                  context: context,
                  builder: (context) => BlurContainerWrapper(child: NotificationIntervalWidget()),
                );
                if (!context.mounted) return;
                Map<String, int>? timeSelected = await showBlurredBottomSheet<Map<String, int>>(
                  context: context,
                  builder: (context) => BlurContainerWrapper(child: NotificationTimeWidget()),
                );
                if (intervalDay == null) {
                  return showBottomConfirmationDialogueAlert(
                    imagePath: "assets/sad.png",
                    title: context.l10n.interval_not_setted,
                    subtitle: context.l10n.interval_not_setted_subtitle,
                    handleConfirm: (context) {
                      context.pop();
                    },
                  );
                }
                if (timeSelected == null) {
                  return showBottomConfirmationDialogueAlert(
                    imagePath: "assets/sad.png",
                    title: context.l10n.notification_time_not_setted,
                    subtitle: context.l10n.notification_time_not_setted_subtitle,
                    handleConfirm: (context) {
                      context.pop();
                    },
                  );
                }
                try {
                  await NotificationHandler().showScheduledNotification(
                      "${context.l10n.notification_check_body_measurement}!",
                      "${context.l10n.notification_check_body_measurement_subtitle}! 💪",
                      intervalDays: intervalDay,
                      hour: timeSelected['hour'] ?? 9,
                      minute: timeSelected['minute'] ?? 30,
                      threadIdentifier: "body_measurement");
                  await showBottomDialogueAlert(
                      imagePath: "assets/congrats.png",
                      title: context.l10n.set_notification_success,
                      subtitle: context.l10n.set_notification_success_subtitle,
                      duration: 2);
                  if (!context.mounted) return;
                  var bodyState = context.read<BodyMeasurementBloc>().state;
                  var memberState = context.read<DetailMemberBloc>().state;
                  if (bodyState is BodyMeasurementSuccess) {
                    if (memberState is DetailMemberSuccess) {
                      context.read<RegisterBodyMeasurementBloc>().add(DoRegisterBodyMeasurement(
                          bodyState.datas.copyWith(
                              bodyFatPercentage: bodyFatNotifier.value,
                              memberCode: memberState.datas.memberCode)));
                    }
                  }
                  context.pop();
                } catch (e) {
                  showBottomDialogueAlert(
                      imagePath: "assets/sad.png",
                      title: context.l10n.set_notification_failed,
                      subtitle: context.l10n.set_notification_failed_subtitle,
                      duration: 2);
                }
              },
            ),
            5.verticalSpacingRadius,
            SizedBox(
              child: TextButton(
                  onPressed: () {
                    if (!context.mounted) return;
                    var bodyState = context.read<BodyMeasurementBloc>().state;
                    var memberState = context.read<DetailMemberBloc>().state;
                    if (bodyState is BodyMeasurementSuccess) {
                      if (memberState is DetailMemberSuccess) {
                        context.read<RegisterBodyMeasurementBloc>().add(DoRegisterBodyMeasurement(
                            bodyState.datas.copyWith(
                                bodyFatPercentage: bodyFatNotifier.value,
                                memberCode: memberState.datas.memberCode)));
                      }
                    }
                  },
                  child: Text(
                    context.l10n.unnecessary,
                    style: TextStyle(
                        color: Colors.red, fontSize: 16.spMin, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
