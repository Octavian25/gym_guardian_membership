import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/notification_handler.dart';
import 'package:os_basecode/os_basecode.dart';

class EventReminderNotificationScreen extends StatefulWidget {
  final CalendarEventData calendarEventData;
  const EventReminderNotificationScreen({super.key, required this.calendarEventData});

  @override
  State<EventReminderNotificationScreen> createState() => _EventReminderNotificationScreenState();
}

class _EventReminderNotificationScreenState extends State<EventReminderNotificationScreen> {
  int selectedMinute = 30;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacingRadius,
              Text(
                context.l10n.chose_notification_time_show_up_title,
                style: bebasNeue.copyWith(fontSize: 30.spMin),
              ),
              Text(
                context.l10n.chose_notification_time_show_up_subtitle,
                style: TextStyle(fontSize: 11.spMin),
              ),
              5.verticalSpacingRadius,
              SizedBox(
                height: 150.h, // Adjust height as needed
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 150.h, // Adjust height as needed
                        child: CupertinoPicker(
                          itemExtent: 40.h, // Adjust item height as needed
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedMinute = index; // Values from 1 to 7
                            });
                          },
                          magnification: 1.2,
                          scrollController: FixedExtentScrollController(initialItem: 9),
                          children: [0, 30, 60, 120, 180, 240, 300]
                              .map((e) => Center(
                                      child: Text(
                                    formatDuration(e),
                                  )))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              5.verticalSpacingRadius,
              PrimaryButton(
                title: context.l10n.select,
                onPressed: () async {
                  await NotificationHandler().showEventReminderNotification(
                      "${context.l10n.event} ${widget.calendarEventData.title} ${context.l10n.almost_started}!",
                      "${context.l10n.lets_get_ready} ${formatDuration(selectedMinute)}.",
                      eventDateTime:
                          widget.calendarEventData.startTime ?? widget.calendarEventData.date,
                      reminderMinutesBefore: selectedMinute,
                      threadIdentifier: "event_reminder");
                  if (!context.mounted) return;
                  context.pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
