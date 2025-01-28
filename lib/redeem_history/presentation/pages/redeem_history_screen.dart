import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/detail_attendance_history/presentation/bloc/fetch_activity_member_bloc/fetch_activity_member_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/redeem_history/domain/entities/redeem_history_entity.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/bloc/cancel_redeem_item_bloc/cancel_redeem_item_bloc.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/bloc/fetch_all_redeem_history_bloc/fetch_all_redeem_history_bloc.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/empty_state_widget.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:os_basecode/os_basecode.dart';

class RedeemHistoryScreen extends StatefulWidget {
  const RedeemHistoryScreen({super.key});

  @override
  State<RedeemHistoryScreen> createState() => _RedeemHistoryScreenState();
}

class _RedeemHistoryScreenState extends State<RedeemHistoryScreen> {
  final PagingController<int, DatumRedeemHistoryEntity> _pagingController =
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
    var state = context.read<FetchAllRedeemHistoryBloc>().state;
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
      context.read<FetchAllRedeemHistoryBloc>().add(DoFetchAllRedeemHistory(
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
    return BlocListener<FetchAllRedeemHistoryBloc, FetchAllRedeemHistoryState>(
      listener: (context, state) {
        if (state.isError) {
          // Tangani error dengan mengatur error pada PagingController
          _pagingController.error = state.errorMessage;
        } else if (!state.isLoading) {
          if (state.reachMax) {
            // Jika sudah mencapai halaman terakhir
            _pagingController.appendLastPage(state.paginated);
          } else {
            // Jika masih ada data untuk ditambahkan
            final nextPage = state.currentPage + 1; // Halaman berikutnya dari state
            _pagingController.appendPage(state.paginated, nextPage);
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
                            "Redeem Item History",
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
                            "Redeem Item History",
                            style: bebasNeue.copyWith(fontSize: 20.spMin),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                PagedSliverList<int, DatumRedeemHistoryEntity>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) {
                      return ListTile(
                        onTap: () {
                          showBlurredBottomSheet(
                            context: context,
                            builder: (context) => BlurContainerWrapper(
                                child: RedeemHistoryDetailWidget(
                              datumRedeemHistoryEntity: item,
                            )),
                          );
                          // showBlurredBottomSheet(
                          //   context: context,
                          //   builder: (context) {
                          //     if (item.attendanceType == "IN") {
                          //       return BlurContainerWrapper(
                          //         child: DetailAttendanceWidget(
                          //           activityMemberEntity: item,
                          //         ),
                          //       );
                          //     } else {
                          //       return BlurContainerWrapper(
                          //         child: DetailAttendanceOutWidget(
                          //           activityMemberEntity: item,
                          //         ),
                          //       );
                          //     }
                          //   },
                          // );
                        },
                        leading: Container(
                          height: 35.h,
                          width: 35.h,
                          decoration: BoxDecoration(
                              color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.history_outlined,
                            color: primaryColor,
                            applyTextScaling: true,
                            weight: 700,
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right_outlined),
                        title: Text(
                          item.itemName,
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
                            "No More Redeem Item History",
                          ),
                        ),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) => EmptyStateWidget(
                        title: "No Redeem Item Recorded",
                        subtitle:
                            "You haven’t redeemed item any sessions yet. Your redeem history will appear here once you check in."),
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

class RedeemHistoryDetailWidget extends StatelessWidget {
  final DatumRedeemHistoryEntity datumRedeemHistoryEntity;
  const RedeemHistoryDetailWidget({super.key, required this.datumRedeemHistoryEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/history2.png",
            width: 0.3.sw,
          ),
          10.verticalSpacingRadius,
          Text("History Redeem Item",
              style: bebasNeue.copyWith(fontSize: 25.spMin, fontWeight: FontWeight.bold)),
          10.verticalSpacingRadius,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Item Name",
                    style: TextStyle(fontSize: 12.spMin),
                  ),
                  Text(
                    datumRedeemHistoryEntity.itemName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.spMin),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Point Used",
                    style: TextStyle(fontSize: 12.spMin),
                  ),
                  Text(
                    datumRedeemHistoryEntity.pointsUsed.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.spMin),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Redeem Status",
                    style: TextStyle(fontSize: 12.spMin),
                  ),
                  Text(
                    datumRedeemHistoryEntity.status == "OPEN"
                        ? "PENDING"
                        : datumRedeemHistoryEntity.status == "CLOSE"
                            ? "REJECTED"
                            : "REDEEMED",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.spMin),
                  ),
                ],
              )
            ],
          ),
          10.verticalSpacingRadius,
          // TextButton(
          //     style: TextButton.styleFrom(foregroundColor: Colors.red),
          //     onPressed: () {
          //       showDialog(
          //         context: context,
          //         builder: (context) => AlertDialog(
          //           title: Text("Cancel Redeem"),
          //           content: Text("Are you sure you want to cancel redeem this item?"),
          //           actions: [
          //             FilledButton(
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: Text("No")),
          //             BlocConsumer<CancelRedeemItemBloc, CancelRedeemItemState>(
          //               listener: (context, state) {
          //                 if (state is CancelRedeemItemSuccess) {
          //                   context.pop();
          //                   Navigator.pop(context);
          //                   showSuccessWithoutButton(state.datas, context);
          //                 }
          //               },
          //               builder: (context, state) {
          //                 return TextButton(
          //                     onPressed: state is CancelRedeemItemLoading
          //                         ? null
          //                         : () {
          //                             context
          //                                 .read<CancelRedeemItemBloc>()
          //                                 .add(DoCancelRedeemItem(datumRedeemHistoryEntity.id));
          //                           },
          //                     child: Text("Yes"));
          //               },
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //     child: Text("Cancel Redeem")),
        ],
      ),
    );
  }
}
