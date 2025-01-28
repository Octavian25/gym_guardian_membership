import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/detail_attendance_history/presentation/bloc/fetch_activity_member_bloc/fetch_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/widgets/widgets.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/empty_state_widget.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:os_basecode/os_basecode.dart';

class DetailAttendanceHistoryScreen extends StatefulWidget {
  const DetailAttendanceHistoryScreen({super.key});

  @override
  State<DetailAttendanceHistoryScreen> createState() => _DetailAttendanceHistoryScreenState();
}

class _DetailAttendanceHistoryScreenState extends State<DetailAttendanceHistoryScreen> {
  final PagingController<int, DatumActivityMemberEntity> _pagingController =
      PagingController(firstPageKey: 1);
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> scrollNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _pagingController.refresh();
        _fetchLastBlocState();
      },
    );
    scrollController.addListener(
      () {
        if (scrollController.position.pixels > 50) {
          scrollNotifier.value = true;
        } else {
          scrollNotifier.value = false;
        }
      },
    );
  }

  void _fetchLastBlocState() {
    var state = context.read<FetchActivityMemberBloc>().state;
    if (state.isError) {
      // Tangani error dengan mengatur error pada PagingController
      _pagingController.error = state.errorMessage;
    } else if (!state.isLoading) {
      if (state.reachMax) {
        // Jika sudah mencapai halaman terakhir
        _pagingController.appendLastPage(state.datas);
      } else {
        // Jika masih ada data untuk ditambahkan
        final nextPage = state.currentPage; // Halaman berikutnya dari state
        _pagingController.appendPage(state.datas, nextPage);
      }
    }
  }

  void _fetchPage(int pageKey) {
    var memberState = context.read<DetailMemberBloc>().state;
    if (memberState is DetailMemberSuccess) {
      context.read<FetchActivityMemberBloc>().add(DoFetchActivityMember(
            memberState.datas.memberCode,
            pageKey,
            10, // Jumlah data per halaman
          ));
    }
  }

  @override
  void dispose() {
    _pagingController.dispose(); // Bersihkan PagingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchActivityMemberBloc, FetchActivityMemberState>(
      listener: (context, state) {
        if (state.isError) {
          // Tangani error dengan mengatur error pada PagingController
          _pagingController.error = state.errorMessage;
        } else if (!state.isLoading) {
          if (state.reachMax) {
            // Jika sudah mencapai halaman terakhir
            _pagingController.appendLastPage(state.paged);
          } else {
            // Jika masih ada data untuk ditambahkan
            final nextPage = state.currentPage + 1; // Halaman berikutnya dari state
            _pagingController.appendPage(state.paged, nextPage);
          }
        }
      },
      child: Scaffold(
        body: Stack(
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
                ValueListenableBuilder(
                  valueListenable: scrollNotifier,
                  builder: (context, isScrolled, child) => SliverAppBar(
                    backgroundColor: Colors.white,
                    forceMaterialTransparency: isScrolled ? false : true,
                    floating: true,
                    pinned: true,
                    title: isScrolled
                        ? Text(
                            "Semua Riwayat Kehadiran",
                            style: bebasNeue.copyWith(fontSize: 20.spMin),
                          )
                        : null,
                  ),
                ),
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
                            "Semua Riwayat Kehadiran",
                            style: bebasNeue.copyWith(fontSize: 20.spMin),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                PagedSliverList<int, DatumActivityMemberEntity>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) {
                      return ListTile(
                        onTap: () {
                          showBlurredBottomSheet(
                            context: context,
                            builder: (context) {
                              if (item.attendanceType == "IN") {
                                return BlurContainerWrapper(
                                  child: DetailAttendanceWidget(
                                    activityMemberEntity: item,
                                  ),
                                );
                              } else {
                                return BlurContainerWrapper(
                                  child: DetailAttendanceOutWidget(
                                    activityMemberEntity: item,
                                  ),
                                );
                              }
                            },
                          );
                        },
                        leading: Container(
                          height: 35.h,
                          width: 35.h,
                          decoration: BoxDecoration(
                              color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
                          child: item.attendanceType == "OUT"
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
                          item.attendanceType == "IN" ? "CHECK IN" : "CHECK OUT",
                          style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          formatDateWithTime(item.inputDate),
                          style: TextStyle(fontSize: 12.spMin),
                        ),
                      );
                    },
                    firstPageErrorIndicatorBuilder: (context) => ErrorBuilderWidget(
                      errorMessage: _pagingController.error.toString(),
                      handleReload: () {
                        _pagingController.refresh();
                      },
                    ),
                    newPageErrorIndicatorBuilder: (context) => ErrorBuilderWidget(
                      errorMessage: _pagingController.error.toString(),
                      handleReload: () {
                        _pagingController.retryLastFailedRequest();
                      },
                    ),
                    noMoreItemsIndicatorBuilder: (context) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Tidak ada lagi data",
                          ),
                        ),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) => EmptyStateWidget(
                        title: "Belum Ada Riwayat Kehadiran",
                        subtitle:
                            "Kamu belum mengikuti sesi apa pun. Riwayat kehadiranmu akan muncul di sini setelah kamu melakukan check-in."),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
