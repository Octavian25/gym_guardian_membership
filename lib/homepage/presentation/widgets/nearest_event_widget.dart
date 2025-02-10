import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/fetch_event_schedule_bloc/fetch_event_schedule_bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/widgets/event_detail_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/empty_state_widget.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';

class NearestEventScheduleWidget extends StatelessWidget {
  const NearestEventScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchEventScheduleBloc, FetchEventScheduleState>(
      builder: (context, state) {
        if (state is FetchEventScheduleSuccess) {
          if (state.datas.filter((e) {
            var event = e.event as Map<String, dynamic>;
            if (event['booked']) {
              if (e.startTime!.isBefore(DateTime.now())) {
                return false;
              }
              return true;
            }
            return false;
          }).isEmpty) {
            return SliverToBoxAdapter(
              child: EmptyStateWidget(
                  title: context.l10n.nearest_event_empty_title,
                  subtitle: context.l10n.nearest_event_empty_subtitle),
            );
          }
          return SliverList.builder(
            itemCount: state.datas.length,
            itemBuilder: (context, index) {
              CalendarEventData data = state.datas[index];
              var event = data.event as Map<String, dynamic>;
              var isBooked = event['booked'] as bool;
              if (!isBooked) {
                return SizedBox.shrink();
              }
              return ListTile(
                onTap: () {
                  showBlurredBottomSheet(
                    context: parentKey.currentContext!,
                    builder: (context) =>
                        BlurContainerWrapper(child: EventDetailWidget(calendarEventData: data)),
                  );
                },
                leading: Container(
                  height: 35.h,
                  width: 35.h,
                  decoration: BoxDecoration(
                      color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.event_available_rounded,
                    color: onPrimaryColor,
                  ),
                ),
                title: Text(
                  data.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${formatDate(data.date)} : ${formatTimeOnly(data.startTime!)}-${formatTimeOnly(data.endTime!)}",
                  style: TextStyle(fontSize: 12.spMin),
                ),
              );
            },
          );
        } else if (state is FetchEventScheduleFailure) {
          return SliverToBoxAdapter(
            child: ErrorBuilderWidget(
              errorMessage: state.message,
              handleReload: () {
                var memberData = getMemberEntityFromBloc(context);
                if (memberData != null) {
                  context
                      .read<FetchEventScheduleBloc>()
                      .add(DoFetchEventSchedule(memberData.memberCode));
                }
              },
            ),
          );
        } else {
          return SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
