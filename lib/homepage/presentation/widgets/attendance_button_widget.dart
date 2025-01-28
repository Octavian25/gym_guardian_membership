import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/register_attendance_reponse_entity.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/register_attendance_bloc/register_attendance_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/widgets.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:os_beacon_finder/beacon_finder.dart';

class AttendanceButtonWidget extends StatelessWidget {
  const AttendanceButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void handleSendRegisterAttendance() {
      var memberState = context.read<DetailMemberBloc>().state;
      if (memberState is DetailMemberSuccess) {
        context
            .read<RegisterAttendanceBloc>()
            .add(DoRegisterAttendance(memberState.datas.memberCode));
      }
    }

    return BlocListener<RegisterAttendanceBloc, RegisterAttendanceState>(
      listener: (context, state) {
        if (state is RegisterAttendanceSuccess) {
          context.read<DetailMemberBloc>().add(DoDetailMember());
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
                title: state.datas.onSite ? "Check Out Attendance" : "Check In Attendance",
                onPressed: () async {
                  if (state.datas.onSite) {
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
                              "Mau Check Out?",
                              style: bebasNeue.copyWith(fontSize: 25.spMin),
                            ),
                            5.verticalSpacingRadius,
                            Text(
                              "Sesi akan berakhir, poin dan kehadiran diperbarui. Oke?",
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
                              child: Text("Tetap di Sini")), // More concise
                          TextButton(
                              style: TextButton.styleFrom(foregroundColor: Colors.red),
                              onPressed: () {
                                dialogContext.pop(true);
                              },
                              child: Text("Check Out")) // More concise
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
                          title: state.datas.onSite
                              ? "Check Out Kehadiran"
                              : "Check In Kehadiran", // Translated
                          cancelText: "Batal", // Translated
                          descriptionTitle: "Dekati Titik Pengecekan", // Translated and improved
                          descriptionSubtitle:
                              "Pastikan Anda berada di dekat lokasi titik pengecekan agar kehadiran Anda tercatat.", // Translated and improved
                          distanceTitle: "Jarak ke Lokasi Titik Pengecekan", // Translated
                          handelBeaconError: (error, stack) {},
                          handelScanningBeaconDone: () {},
                          handleBeaconFound: (beaconDetail) {
                            handleSendRegisterAttendance();
                          },
                        ),
                      );
                    },
                  );
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
