import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/register_attendance_reponse_entity.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/register_attendance_bloc/register_attendance_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/widgets.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:os_beacon_finder/beacon_finder.dart';

class AttendanceButtonWidget extends StatefulWidget {
  const AttendanceButtonWidget({
    super.key,
  });

  @override
  State<AttendanceButtonWidget> createState() => AttendanceButtonWidgetState();
}

class AttendanceButtonWidgetState extends State<AttendanceButtonWidget> {
  void startAttendanceProcedure(
      bool onSite, bool showCheckoutConfirmation, String eligibleForPoints) async {
    if (onSite && showCheckoutConfirmation) {
      var checkOutConfirm = await showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/cancel_booking.png",
                width: 0.3.sw,
              ),
              10.verticalSpacingRadius,
              Text(
                context.l10n.checkout_confirmation_title,
                style: bebasNeue.copyWith(fontSize: 25.spMin),
              ),
              5.verticalSpacingRadius,
              Text(
                context.l10n.checkout_confirmation_subtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsOverflowDirection: VerticalDirection.down,
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: [
            FilledButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () {
                  dialogContext.pop(false);
                  return;
                },
                child: Text(context.l10n.checkout_confirmation_negative)), // More concise
            TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  dialogContext.pop(true);
                },
                child: Text(context.l10n.check_out)) // More concise
          ],
        ),
      );
      if (!checkOutConfirm) {
        return;
      }
    }

    showBlurredBottomSheet(
      context: parentKey.currentContext!,
      builder: (context) {
        return BlurContainerWrapper(
          child: ScanningBeaconWidget(
            title: onSite
                ? "${context.l10n.check_out} ${context.l10n.attendance}"
                : "${context.l10n.check_in} ${context.l10n.attendance}", // Translated
            cancelText: context.l10n.cancel, // Translated
            descriptionTitle: context.l10n.beacon_scan_title, // Translated and improved
            descriptionSubtitle: context.l10n.beacon_scan_subtitle, // Translated and improved
            distanceTitle: context.l10n.beacon_distance, // Translated
            handelBeaconError: (error, stack) {},
            handelScanningBeaconDone: () {},
            handleBeaconFound: (beaconDetail) {
              var memberState = context.read<DetailMemberBloc>().state;
              if (memberState is DetailMemberSuccess) {
                context
                    .read<RegisterAttendanceBloc>()
                    .add(DoRegisterAttendance(memberState.datas.memberCode, eligibleForPoints));
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterAttendanceBloc, RegisterAttendanceState>(
      listener: (context, state) {
        if (state is RegisterAttendanceSuccess) {
          context.read<DetailMemberBloc>().add(DoDetailMember(false));
          RegisterAttendanceResponseEntity data = state.datas;
          context.pop();
          showBlurredBottomSheet(
            context: parentKey.currentContext!,
            builder: (context) {
              if (data.attendanceType == "IN") {
                return BlurContainerWrapper(
                  child: DetailAttendancePopupWidget(
                    activityMemberEntity: data,
                  ),
                );
              } else {
                return BlurContainerWrapper(
                  child: DetailAttendanceOutPopupWidget(
                    activityMemberEntity: data,
                  ),
                );
              }
            },
          );
        }
      },
      child: SliverToBoxAdapter(
        child: BlocBuilder<DetailMemberBloc, DetailMemberState>(
          builder: (context, state) {
            if (state is DetailMemberSuccess) {
              return PrimaryButton(
                title: state.datas.onSite
                    ? "${context.l10n.check_out} ${context.l10n.attendance}"
                    : "${context.l10n.check_in} ${context.l10n.attendance}",
                onPressed: () async {
                  startAttendanceProcedure(state.datas.onSite, true, "YES");
                },
              ).animate().slideY(begin: -0.1, end: 0).fadeIn();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
