import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/reservation_event_schedule_bloc/reservation_event_schedule_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/event_reminder_notification.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:os_basecode/os_basecode.dart';

class EventDetailWidget extends StatelessWidget {
  final CalendarEventData calendarEventData;
  const EventDetailWidget({
    super.key,
    required this.calendarEventData,
  });

  @override
  Widget build(BuildContext context) {
    var event = calendarEventData.event as Map<String, dynamic>;
    var reservedMember = event['booked'] as bool;
    var titleButton = context.l10n.scheduled;
    var isEnabled = true;
    if (reservedMember) {
      titleButton = context.l10n.already_scheduled;
      isEnabled = false;
    }
    if (calendarEventData.startTime!.isBefore(DateTime.now())) {
      titleButton = context.l10n.scheduled_passed;
      isEnabled = false;
    }
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            10.verticalSpacingRadius,
            Center(
              child: Image.asset(
                "assets/attendance.png",
                width: 0.25.sw,
              ),
            ),
            20.verticalSpacingRadius,
            Text(
              calendarEventData.title,
              style: bebasNeue.copyWith(fontSize: 30.spMin),
            ),
            5.verticalSpacingRadius,
            Text(
              calendarEventData.description ?? "-",
            ),
            10.verticalSpacingRadius,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.start,
                        style: TextStyle(fontSize: 12.spMin),
                      ),
                      5.verticalSpacingRadius,
                      Text(
                        calendarEventData.startTime == null
                            ? "-"
                            : formatTimeOnly(calendarEventData.startTime!.toLocal()),
                        style: bebasNeue.copyWith(fontSize: 25.spMin),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [Icon(Icons.arrow_forward)],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.until,
                        style: TextStyle(fontSize: 12.spMin),
                      ),
                      5.verticalSpacingRadius,
                      Text(
                        calendarEventData.endTime == null
                            ? "-"
                            : formatTimeOnly(calendarEventData.endTime!.toLocal()),
                        style: bebasNeue.copyWith(fontSize: 25.spMin),
                      ),
                    ],
                  ),
                )
              ],
            ),
            10.verticalSpacingRadius,
            Divider(
              color: onPrimaryColor.withValues(alpha: 0.1),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.max_quota,
                        style: TextStyle(fontSize: 12.spMin),
                      ),
                      5.verticalSpacingRadius,
                      Text(
                        event['maxQuota'].toString(),
                        style: bebasNeue.copyWith(fontSize: 25.spMin),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.available_quota,
                        style: TextStyle(fontSize: 12.spMin),
                      ),
                      5.verticalSpacingRadius,
                      Text(
                        event['availableQuota'].toString(),
                        style: bebasNeue.copyWith(fontSize: 25.spMin),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.reservation,
                        style: TextStyle(fontSize: 12.spMin),
                      ),
                      5.verticalSpacingRadius,
                      Text(
                        event['reservations'].toString(),
                        style: bebasNeue.copyWith(fontSize: 25.spMin),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: onPrimaryColor.withValues(alpha: 0.1),
            ),
            20.verticalSpacingRadius,
            PrimaryButton(
              title: titleButton,
              onPressed: isEnabled
                  ? () {
                      var memberEntity = getMemberEntityFromBloc(context);
                      if (memberEntity == null) {
                        showError("Failed get data from server", context);
                        return;
                      }
                      showBottomConfirmationDialogueAlert(
                        imagePath: "assets/question.png",
                        title: context.l10n.booking_event_confirm_title,
                        subtitle: context.l10n.booking_event_confirm_subtitle,
                        handleConfirm: (context) async {
                          await showBlurredBottomSheet(
                            context: context,
                            builder: (context) => BlurContainerWrapper(
                                child: EventReminderNotificationScreen(
                              calendarEventData: calendarEventData,
                            )),
                          );
                          if (!context.mounted) return;
                          context.pop();
                          context.read<ReservationEventScheduleBloc>().add(
                              DoReservationEventSchedule(event['event'], memberEntity.memberCode));
                        },
                      );
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
