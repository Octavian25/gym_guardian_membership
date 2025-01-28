import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:gym_guardian_membership/detail_point/presentation/bloc/fetch_detail_point_bloc/fetch_detail_point_bloc.dart';
import 'package:gym_guardian_membership/detail_point/presentation/widgets/point_in_widget.dart';
import 'package:gym_guardian_membership/detail_point/presentation/widgets/point_out_widget.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/empty_state_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:os_basecode/os_basecode.dart';

class DetailPointScreen extends StatefulWidget {
  const DetailPointScreen({super.key});

  @override
  State<DetailPointScreen> createState() => _DetailPointScreenState();
}

class _DetailPointScreenState extends State<DetailPointScreen> {
  final PagingController<int, DatumPointHistoryEntity> _pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _fetchLastBlocState();
      },
    );
  }

  void _fetchLastBlocState() {
    var state = context.read<FetchDetailPointBloc>().state;
    if (state.isError) {
      // Tangani error dengan mengatur error pada PagingController
      _pagingController.error = state.errorMessage;
    } else if (!state.isLoading) {
      if (state.reachMax) {
        // Jika sudah mencapai halaman terakhir
        _pagingController.appendLastPage(state.datas);
      } else {
        // Jika masih ada data untuk ditambahkan
        final nextPage = state.currentPage + 1; // Halaman berikutnya dari state
        _pagingController.appendPage(state.datas, nextPage);
      }
    }
  }

  void _fetchPage(int pageKey) {
    var memberState = context.read<DetailMemberBloc>().state;
    if (memberState is DetailMemberSuccess) {
      context.read<FetchDetailPointBloc>().add(DoFetchDetailPoint(
            memberState.datas.memberCode,
            pageKey + 1,
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
    return BlocListener<FetchDetailPointBloc, FetchDetailPointState>(
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
                SliverAppBar(
                  forceMaterialTransparency: true,
                ),
                SliverToBoxAdapter(
                  child: Hero(
                          tag: "points_icon",
                          child: Image.asset(
                            "assets/points.png",
                            height: 120.h,
                          ))
                      .animate(
                        onPlay: (controller) => controller.repeat(
                          reverse: true,
                          period: 3.seconds,
                        ),
                      )
                      .scaleXY(begin: 0.9, end: 1)
                      .shimmer(),
                ),
                SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                SliverToBoxAdapter(
                    child: Center(
                  child: Text("Poin:"),
                ).animate().slideY(begin: -0.3, end: 0)),
                BlocBuilder<DetailMemberBloc, DetailMemberState>(
                  builder: (context, state) {
                    if (state is DetailMemberSuccess) {
                      return SliverToBoxAdapter(
                          child: Center(
                        child: Text(
                          state.datas.point.toString(),
                          style: bebasNeue.copyWith(fontSize: 35.spMin),
                        ),
                      ).animate().slideY(begin: 0.3, end: 0));
                    } else if (state is DetailMemberFailure) {
                      return ErrorBuilderWidget(
                        errorMessage: state.message,
                        handleReload: () {
                          context.read<DetailMemberBloc>().add(DoDetailMember());
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                SliverToBoxAdapter(
                    child: Center(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        context.go("/homepage/detail-points/redeem");
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Tukar Poin",
                          style: TextStyle(fontSize: 12.spMin),
                        ),
                      ),
                    ),
                  ),
                )),
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
                            "Riwayat Poin",
                            style: bebasNeue.copyWith(fontSize: 20.spMin),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                PagedSliverList<int, DatumPointHistoryEntity>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) {
                      if (item.pointIn >= 0) {
                        return PointInWidget(
                          data: item,
                        );
                      } else {
                        return PointOutWidget(
                          data: item,
                        );
                      }
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
                    firstPageProgressIndicatorBuilder: (context) => CircularProgressIndicator(),
                    noItemsFoundIndicatorBuilder: (context) => EmptyStateWidget(
                        title: "Riwayat Poin Kosong",
                        subtitle:
                            "Kumpulkan atau gunakan poin untuk melihat aktivitas Anda di sini."),
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
