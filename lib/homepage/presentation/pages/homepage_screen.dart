import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/bloc/fetch_body_measurement_bloc/fetch_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/fetch_event_schedule_bloc/fetch_event_schedule_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_activity_member_bloc/fetch_last_three_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_booking_bloc/fetch_last_three_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/register_attendance_bloc/register_attendance_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/attendance_button_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/last_three_attendance_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/nearest_event_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/widgets.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/geolocator_helper.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:os_updater/os_updater.dart';

class HomepageScreen extends StatefulWidget {
  final String? extra;
  const HomepageScreen({super.key, this.extra});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> scrollNotifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    if (widget.extra != null && widget.extra == "fetch") {
      context.read<DetailMemberBloc>().add(DoDetailMember(true));
    }
    scrollController.addListener(
      () {
        if (scrollController.position.pixels > 50) {
          scrollNotifier.value = true;
        } else {
          scrollNotifier.value = false;
        }
      },
    );
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (Platform.isAndroid) {
          await UpdateManager.instance.checkForUpdate(
              "LoyalityMembership", // App name
              appVersion, // Current app version
              context // Context to display the dialog
              );
        }
      },
    );
  }

  GlobalKey<AttendanceButtonWidgetState> attendanceKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailMemberBloc, DetailMemberState>(
        listener: (context, state) async {
          if (state is DetailMemberSuccess) {
            context
                .read<FetchLastThreeBookingBloc>()
                .add(DoFetchLastThreeBooking(state.datas.memberCode, 1, 3));
            context
                .read<FetchLastThreeActivityMemberBloc>()
                .add(DoFetchLastThreeActivityMember(state.datas.memberCode, 1, 3));
            context
                .read<FetchEventScheduleBloc>()
                .add(DoFetchEventSchedule(state.datas.memberCode));
            context.read<FetchBodyMeasurementBloc>().add(DoFetchBodyMeasurement(
                  state.datas.memberCode,
                ));
            if (await checkIsOnLocation()) {
              if (state.initState) {
                if (!state.datas.onSite) {
                  if (!context.mounted) return;
                  await showBottomConfirmationDialogueAlert(
                      imagePath: "assets/gym_building.png",
                      title: "${context.l10n.you_already_in} Kantor Nagatech Cilengkrang",
                      subtitle:
                          "Hay ${state.datas.memberName}, ${context.l10n.auto_check_in_message}",
                      handleConfirm: (context) {
                        context.pop();
                        var memberEntity = getMemberEntityFromBloc(context);
                        if (memberEntity != null) {
                          attendanceKey.currentState!
                              .startAttendanceProcedure(memberEntity.onSite, false, "YES");
                        }
                      },
                      showSecondaryButton: true,
                      secondaryButtonText: context.l10n.auto_check_in_negative,
                      handleCancel: (context) {
                        context.pop();
                      },
                      buttonText: context.l10n.auto_check_in_positive);
                }
              }
            } else {
              if (state.datas.onSite) {
                if (state.initState) {
                  if (!context.mounted) return;
                  await showBottomConfirmationDialogueAlert(
                    imagePath: "assets/gym_building.png",
                    title: "${context.l10n.you_already_out} Kantor Nagatech Cilengkrang",
                    subtitle:
                        "Hay ${state.datas.memberName}, ${context.l10n.auto_check_out_message}",
                    handleConfirm: (context) {
                      var memberState = context.read<DetailMemberBloc>().state;
                      if (memberState is DetailMemberSuccess) {
                        context
                            .read<RegisterAttendanceBloc>()
                            .add(DoRegisterAttendance(memberState.datas.memberCode, "NO"));
                      }
                    },
                  );
                }
              }
            }
          } else if (state is DetailMemberFailure) {
            await showBottomConfirmationDialogueAlert(
              imagePath: "assets/sad.png",
              title: context.l10n.failed_fetch_member_title, // Translated title
              subtitle: context.l10n
                  .failed_fetch_member_subtitle, // Translated subtitle.  More natural phrasing.
              handleConfirm: (context) {
                context.pop();
                context.read<DetailMemberBloc>().add(DoDetailMember(false));
              },
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  "assets/background_home.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              CustomScrollView(
                controller: scrollController,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  AppBarHomepage(scrollNotifier: scrollNotifier),
                  SliverToBoxAdapter(
                    child: 10.verticalSpacingRadius,
                  ),
                  if (state is DetailMemberSuccess && !state.datas.status) activationMemberText(),
                  if (state is DetailMemberSuccess && state.datas.status)
                    baseSliverPadding(
                      sliver: LoyalityInformationWidget(),
                    ),
                  if (state is DetailMemberSuccess && state.datas.status)
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                  if (state is DetailMemberSuccess && state.datas.status)
                    baseSliverPadding(
                        sliver: AttendanceButtonWidget(
                      key: attendanceKey,
                    )),
                  if (state is DetailMemberSuccess && state.datas.status)
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                  if (state is DetailMemberSuccess && state.datas.status)
                    baseSliverPadding(sliver: BookingSlotInformationWidget()),
                  SliverToBoxAdapter(child: 15.verticalSpacingRadius),
                  baseSliverPadding(
                      sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.l10n.nearest_event,
                              style: bebasNeue.copyWith(fontSize: 20.spMin),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                  NearestEventScheduleWidget(),
                  SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                  baseSliverPadding(
                      sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.l10n.booking_history,
                              style: bebasNeue.copyWith(fontSize: 20.spMin),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                  LastThreeBookingWidget(),
                  SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                  baseSliverPadding(
                      sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.l10n.attendance_history,
                              style: bebasNeue.copyWith(fontSize: 20.spMin),
                            ),
                            Text(
                              context.l10n.attendance_history_subtitle,
                              style: TextStyle(fontSize: 11.spMin),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  LastThreeAttendanceWidget(),
                  BlocBuilder<FetchLastThreeActivityMemberBloc, FetchLastThreeActivityMemberState>(
                    builder: (context, state) {
                      if (state is FetchLastThreeActivityMemberSuccess) {
                        if (state.datas.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Container(),
                          );
                        }
                        return baseSliverPadding(
                            sliver: SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: () {
                                    context.go("/homepage/detail-attendance");
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    child: Text(
                                      context.l10n.attendance_history_show_all,
                                      style: TextStyle(fontSize: 10.spMin),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                      } else {
                        return SliverToBoxAdapter(
                          child: Container(),
                        );
                      }
                    },
                  ),
                  SliverToBoxAdapter(child: 20.verticalSpacingRadius)
                ],
              )
            ],
          );
        },
      ),
    );
  }

  SliverPadding activationMemberText() {
    return baseSliverPadding(
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              5.verticalSpacingRadius,
              Image.asset(
                "assets/history2.png",
                width: 60.h,
                height: 60.h,
              ),
              10.verticalSpacingRadius,
              Text(context.l10n.your_account_not_active_title, // More natural phrasing
                  style: bebasNeue.copyWith(
                      fontSize: 20.spMin, color: Colors.white, fontWeight: FontWeight.bold)),
              5.verticalSpacingRadius,
              Text(context.l10n.your_account_not_active_subtitle, // Improved phrasing and wording
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.spMin, color: onPrimaryColor)),
              5.verticalSpacingRadius,
            ],
          ),
        ),
      ),
    );
  }
}
