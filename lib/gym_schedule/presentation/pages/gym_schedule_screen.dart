import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/fetch_event_schedule_bloc/fetch_event_schedule_bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/reservation_event_schedule_bloc/reservation_event_schedule_bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/widgets/event_detail_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:gym_guardian_membership/utility/show_bottom_dialog.dart';
import 'package:os_basecode/os_basecode.dart';

class GymScheduleScreen extends StatefulWidget {
  const GymScheduleScreen({super.key});

  @override
  State<GymScheduleScreen> createState() => _GymScheduleScreenState();
}

class _GymScheduleScreenState extends State<GymScheduleScreen> {
  List<CalendarEventData<Object?>> listEventToday = [];
  DateTime selected = DateTime.now();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var memberData = getMemberEntityFromBloc(context);
        if (memberData != null) {
          CalendarControllerProvider.of(context).controller.clear();
          context.read<FetchEventScheduleBloc>().add(DoFetchEventSchedule(memberData.memberCode));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FetchEventScheduleBloc, FetchEventScheduleState>(
          listener: (context, state) {
            if (state is FetchEventScheduleLoading) {}
            if (state is FetchEventScheduleSuccess) {
              CalendarControllerProvider.of(context).controller.addAll(state.datas);
              setState(() {
                listEventToday = CalendarControllerProvider.of(context)
                    .controller
                    .getEventsOnDay(DateTime.now());
                selected = DateTime.now();
              });
            } else if (state is FetchEventScheduleFailure) {
              showError(state.message, context);
            }
          },
        ),
        BlocListener<ReservationEventScheduleBloc, ReservationEventScheduleState>(
          listener: (context, state) {
            if (state is ReservationEventScheduleSuccess) {
              var eventState = context.read<FetchEventScheduleBloc>().state;
              if (eventState is FetchEventScheduleSuccess) {
                CalendarControllerProvider.of(context).controller.removeAll(eventState.datas);
              }
              context.pop();
              showBottomDialogueAlert(
                  imagePath: "assets/congrats.png",
                  title: context.l10n.reservation_event_success,
                  subtitle: context.l10n.reservation_event_success_subtitle,
                  duration: 2);
              var memberData = getMemberEntityFromBloc(context);
              if (memberData != null) {
                context
                    .read<FetchEventScheduleBloc>()
                    .add(DoFetchEventSchedule(memberData.memberCode));
              }
            } else if (state is ReservationEventScheduleFailure) {
              showBottomDialogueAlert(
                  imagePath: "assets/sad.png",
                  title: context.l10n.reservation_event_failed,
                  subtitle: context.l10n.reservation_event_failed_subtitle,
                  duration: 2);
            }
          },
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.gym_schedule,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.spMin),
              ),
              Text(
                context.l10n.gym_schedule_subtitle,
                style: TextStyle(fontSize: 11.spMin),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                "assets/background_home.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 0.6.sh,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: MonthView(
                          headerStringBuilder: (date, {secondaryDate}) {
                            return getMonthAndYearOnly(date);
                          },
                          showBorder: false,
                          showWeekTileBorder: false,
                          useAvailableVerticalSpace: true,
                          weekDayBuilder: (day) => Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(getDayName(day).substring(0, 3))),
                          ),
                          onCellTap: (events, date) {
                            setState(() {
                              listEventToday.clear();
                              listEventToday = events;
                              selected = date;
                            });
                          },
                          cellBuilder: (date, event, isToday, isInMonth, hideDaysNotInMonth) {
                            if (!isInMonth) {
                              return SizedBox.shrink();
                            }
                            return Container(
                              decoration: BoxDecoration(
                                  color: isToday
                                      ? date == selected
                                          ? primaryColor
                                          : Colors.transparent
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: date == selected
                                      ? Border.all(color: primaryColor, width: 2)
                                      : null),
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                              child: Container(
                                  padding: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (event.isNotEmpty)
                                        Container(
                                          height: 4,
                                          width: 4,
                                          decoration: BoxDecoration(
                                              color: Colors.grey, shape: BoxShape.circle),
                                        ),
                                      Center(
                                        child: Text(
                                          date.day.toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 18.spMin,
                                              fontWeight: FontWeight.bold,
                                              color: isToday
                                                  ? date == selected
                                                      ? Colors.white
                                                      : primaryColor
                                                  : null),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          },
                          hideDaysNotInMonth: true,
                          headerStyle: HeaderStyle(
                              decoration: BoxDecoration(color: Colors.transparent),
                              headerTextStyle: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: listEventToday.isEmpty
                      ? Center(
                          child: Text(
                            context.l10n.no_event_today,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: listEventToday.length,
                          separatorBuilder: (context, index) => 10.verticalSpacingRadius,
                          itemBuilder: (context, index) {
                            var e = listEventToday[index];
                            var event = e.event as Map<String, dynamic>;
                            var isBooked = event['booked'] as bool;
                            return GestureDetector(
                              onTap: () {
                                showBlurredBottomSheet(
                                  context: parentKey.currentContext!,
                                  builder: (context) => BlurContainerWrapper(
                                      child: EventDetailWidget(calendarEventData: e)),
                                );
                              },
                              child: Container(
                                width: 1.sw,
                                decoration: BoxDecoration(
                                    color: e.startTime!.isBefore(DateTime.now())
                                        ? Colors.grey.shade300
                                        : primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.spMin,
                                                color: onPrimaryColor),
                                          ),
                                          Text(
                                            "${formatTimeOnly(e.startTime ?? DateTime.now())}-${formatTimeOnly(e.endTime ?? DateTime.now())}",
                                            style: TextStyle(
                                                fontSize: 12.spMin, color: onPrimaryColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (isBooked)
                                      Center(
                                        child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Text(
                                              context.l10n.scheduled,
                                              style: TextStyle(
                                                  fontSize: 11.spMin, color: onPrimaryColor),
                                            )),
                                      )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
