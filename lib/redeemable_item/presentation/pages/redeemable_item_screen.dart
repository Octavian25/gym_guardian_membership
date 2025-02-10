import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';

import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/entities/redeemable_item_entity.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/bloc/fetch_all_redeemable_item_bloc/fetch_all_redeemable_item_bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/bloc/redeem_item_bloc/redeem_item_bloc.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/empty_state_widget.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:gym_guardian_membership/utility/show_bottom_dialog.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:os_basecode/os_basecode.dart';

class RedeemableItemScreen extends StatefulWidget {
  const RedeemableItemScreen({super.key});

  @override
  State<RedeemableItemScreen> createState() => _RedeemableItemScreenState();
}

class _RedeemableItemScreenState extends State<RedeemableItemScreen> {
  final PagingController<int, DatumRedeemableItemEntity> _pagingController =
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
    var state = context.read<FetchAllRedeemableItemBloc>().state;
    if (state.isError) {
      // Tangani error dengan mengatur error pada PagingController
      _pagingController.error = state.errorMessage;
    } else if (!state.isLoading) {
      if (state.reachMax) {
        // Jika sudah mencapai halaman terakhir
        _pagingController.appendLastPage(state.datas);
      } else {
        final nextPage = state.currentPage + 1; // Halaman berikutnya dari state
        _pagingController.appendPage(state.datas, nextPage);
      }
    }
  }

  void _fetchPage(int pageKey) {
    log("REDEEMBALE PAGE $pageKey", name: "DoFetchAllRedeemableItem");
    context.read<FetchAllRedeemableItemBloc>().add(DoFetchAllRedeemableItem(
          pageKey,
          10, // Jumlah data per halaman
        ));
  }

  @override
  void dispose() {
    _pagingController.dispose(); // Bersihkan PagingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchAllRedeemableItemBloc, FetchAllRedeemableItemState>(
      listener: (context, state) {
        if (state.isError) {
          // Tangani error dengan mengatur error pada PagingController
          _pagingController.error = state.errorMessage;
        } else if (!state.isLoading) {
          if (state.reachMax) {
            _pagingController.appendLastPage(state.paginated);
          } else {
            // Jika masih ada data untuk ditambahkan
            final nextPageKey = state.currentPage + 1;
            _pagingController.appendPage(state.paginated, nextPageKey);
          }
        }
      },
      child: BlocListener<RedeemItemBloc, RedeemItemState>(
        listener: (context, state) {
          if (state is RedeemItemSuccess) {
            context.pop();
            showBottomConfirmationDialogueAlert(
              imagePath: "assets/congrats.png",
              title: "Redeem Success!",
              subtitle:
                  "Your redeem request has been processed successfully. Please visit our store and show your unique code to our staff to claim your item. You can also check your redemption history by tapping the icon at the top. Thank you for using our service!",
              handleConfirm: (context) {
                context.read<DetailMemberBloc>().add(DoDetailMember(false));
                context.pop();
              },
            );
          } else if (state is RedeemItemFailure) {
            context.pop();
            showBottomDialogueAlert(
                imagePath: "assets/sad.png",
                title: "Redeem Failed!",
                subtitle: state.message,
                duration: 3);
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
                      actions: [
                        IconButton(
                            onPressed: () {
                              context.go("/homepage/detail-points/redeem/history");
                            },
                            icon: Icon(Icons.history_rounded)),
                        16.horizontalSpaceRadius,
                      ],
                      backgroundColor: Colors.white,
                      forceMaterialTransparency: isScrolled ? false : true,
                      floating: true,
                      pinned: true,
                      title: isScrolled
                          ? Text(
                              "Detail Redeemable Items",
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
                              "Detail Redeemable Items",
                              style: bebasNeue.copyWith(fontSize: 20.spMin),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  PagedSliverList<int, DatumRedeemableItemEntity>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, item, index) {
                        return ListTile(
                          onTap: () {
                            showBottomConfirmationDialogueAlert(
                              imagePath: "assets/history.png",
                              title: "${item.name} (${item.pointsRequired} Point) ",
                              subtitle:
                                  "Are you sure you want to redeem this item? Please double-check your selection, as this action cannot be undone.",
                              handleConfirm: (context) {
                                var memberState = context.read<DetailMemberBloc>().state;
                                if (memberState is DetailMemberSuccess) {
                                  context
                                      .read<RedeemItemBloc>()
                                      .add(DoRedeemItem(memberState.datas.memberCode, item.id));
                                }
                              },
                            );
                          },
                          leading: Container(
                            height: 35.h,
                            width: 35.h,
                            decoration: BoxDecoration(
                                color: "#F5F5F5".toColor(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.redeem_rounded,
                              color: primaryColor,
                              applyTextScaling: true,
                              weight: 700,
                            ),
                          ),
                          trailing: Icon(Icons.chevron_right_outlined),
                          title: Text(
                            item.name,
                            style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Point Required : ${item.pointsRequired}",
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
                              "No More Redeemable Items",
                            ),
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) => EmptyStateWidget(
                          title: "No Redeemable Items Available",
                          subtitle:
                              "Currently, there are no items available for redemption. Please check back later to see new and exciting rewards!"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
