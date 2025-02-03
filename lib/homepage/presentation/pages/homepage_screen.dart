import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_activity_member_bloc/fetch_last_three_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_booking_bloc/fetch_last_three_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/attendance_button_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/last_three_attendance_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/widgets.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
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
      context.read<DetailMemberBloc>().add(DoDetailMember());
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
          } else if (state is DetailMemberFailure) {
            await showBottomConfirmationDialogueAlert(
              imagePath: "assets/sad.png",
              title: "Gagal Mengambil Detail Member", // Translated title
              subtitle:
                  "Terjadi masalah saat mengambil data member. Silakan periksa koneksi internet Anda dan coba lagi.", // Translated subtitle.  More natural phrasing.
              handleConfirm: (context) {
                context.pop();
                context.read<DetailMemberBloc>().add(DoDetailMember());
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
                slivers: [
                  AppBarHomepage(scrollNotifier: scrollNotifier),
                  SliverToBoxAdapter(
                    child: 10.verticalSpacingRadius,
                  ),
                  if (state is DetailMemberSuccess && !state.datas.status)
                    baseSliverPadding(
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/points.png",
                                width: 60.h,
                                height: 60.h,
                              ),
                              Text("Akun Anda Belum Aktif", // More natural phrasing
                                  style: bebasNeue.copyWith(
                                      fontSize: 20.spMin,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "Silakan hubungi admin untuk aktivasi akun dan jangan lupa untuk membayar biaya berlangganan.", // Improved phrasing and wording
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.spMin,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (state is DetailMemberSuccess && state.datas.status)
                    baseSliverPadding(
                      sliver: LoyalityInformationWidget(),
                    ),
                  if (state is DetailMemberSuccess && state.datas.status)
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                  if (state is DetailMemberSuccess && state.datas.status)
                    baseSliverPadding(sliver: AttendanceButtonWidget()),
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
                              "Riwayat Booking Terbaru",
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
                              "Riwayat Kehadiran",
                              style: bebasNeue.copyWith(fontSize: 20.spMin),
                            ),
                            Text(
                              "Kita hanya menampilkan 3 riwayat terakhir",
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
                                      "Lihat Semua Riwayat Kehadiran",
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
}
