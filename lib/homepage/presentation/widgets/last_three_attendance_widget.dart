import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_activity_member_bloc/fetch_last_three_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/widgets.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/empty_state_widget.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LastThreeAttendanceWidget extends StatelessWidget {
  const LastThreeAttendanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLastThreeActivityMemberBloc, FetchLastThreeActivityMemberState>(
      builder: (context, state) {
        if (state is FetchLastThreeActivityMemberFailure) {
          return SliverToBoxAdapter(
            child: ErrorBuilderWidget(
              errorMessage: state.message,
              handleReload: () {
                var memberState = context.read<DetailMemberBloc>().state;
                if (memberState is DetailMemberSuccess) {
                  context
                      .read<FetchLastThreeActivityMemberBloc>()
                      .add(DoFetchLastThreeActivityMember(memberState.datas.memberCode, 1, 3));
                }
              },
            ),
          );
        } else if (state is FetchLastThreeActivityMemberSuccess) {
          if (state.datas.isEmpty) {
            return SliverToBoxAdapter(
                child: EmptyStateWidget(
              title: "Belum Ada Riwayat Kehadiran", // Translated
              subtitle: "Kamu belum absen. Riwayat kehadiran akan muncul setelah kamu check-in.",
            ));
          }

          return SliverList.builder(
            itemCount: state.datas.length > 3 ? 3 : state.datas.length,
            itemBuilder: (context, index) {
              DatumActivityMemberEntity data = state.datas[index];
              return ListTile(
                onTap: () {
                  showBlurredBottomSheet(
                    context: context,
                    builder: (context) {
                      if (data.attendanceType == "IN") {
                        return BlurContainerWrapper(
                          child: DetailAttendanceWidget(
                            activityMemberEntity: data,
                          ),
                        );
                      } else {
                        return BlurContainerWrapper(
                            child: DetailAttendanceOutWidget(
                          activityMemberEntity: data,
                        ));
                      }
                    },
                  );
                },
                leading: Container(
                  height: 35.h,
                  width: 35.h,
                  decoration: BoxDecoration(
                      color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
                  child: data.attendanceType == "OUT"
                      ? Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                          applyTextScaling: true,
                          weight: 700,
                        )
                      : Icon(
                          Icons.login_rounded,
                          color: primaryColor,
                          applyTextScaling: true,
                          weight: 700,
                        ),
                ),
                trailing: Icon(Icons.chevron_right_outlined),
                title: Text(
                  data.attendanceType == "IN" ? "CHECK IN" : "CHECK OUT",
                  style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  formatDateWithTime(data.inputDate),
                  style: TextStyle(fontSize: 12.spMin),
                ),
              );
            },
          );
        } else if (state is FetchLastThreeActivityMemberLoading) {
          return Skeletonizer.sliver(
            child: SliverList.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Container(
                  color: Colors.red,
                  height: 35.h,
                  width: 35.h,
                ),
                title: Text("Skeletonizer Longer Title"),
                subtitle: Text("Skeletonizer"),
              ),
              itemCount: 3,
            ),
          );
        } else {
          return SliverToBoxAdapter(child: Container());
        }
      },
    );
  }
}
