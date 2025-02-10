part of 'widgets.dart';

class LoyalityInformationWidget extends StatelessWidget {
  const LoyalityInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<DetailMemberBloc, DetailMemberState>(
        builder: (context, state) {
          if (state is DetailMemberSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10.w,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.go('/homepage/detail-points');
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: '#696969'.toColor().withValues(alpha: 0.26))),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                                minRadius: 20.w,
                                backgroundColor: primaryColor.withValues(alpha: 0.2),
                                child: Hero(
                                  tag: "points_icon",
                                  child: Image.asset(
                                    "assets/points.png",
                                    width: 30,
                                  ),
                                )),
                            5.verticalSpacingRadius,
                            Text(
                              state.datas.point.toString(),
                              style: bebasNeue.copyWith(fontSize: 18.spMin),
                            ),
                            Text(
                              context.l10n.point,
                              style: TextStyle(fontSize: 12.spMin),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ).animate().slideX(begin: -0.2, end: 0).fadeIn(),
                // Expanded(
                //   child: Material(
                //     color: Colors.transparent,
                //     child: InkWell(
                //       onTap: () {
                //         context.go('/homepage/detail-coupon');
                //       },
                //       child: Ink(
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(20),
                //             border: Border.all(color: '#696969'.toColor().withValues(alpha: 0.26))),
                //         padding: EdgeInsets.symmetric(vertical: 10),
                //         child: Column(
                //           children: [
                //             CircleAvatar(
                //                 minRadius: 20.w,
                //                 backgroundColor: primaryColor.withValues(alpha: 0.2),
                //                 child: Hero(
                //                   tag: "coupon_icon",
                //                   child: Image.asset(
                //                     "assets/voucher.png",
                //                     width: 30,
                //                   ),
                //                 )),
                //             5.verticalSpacingRadius,
                //             Text(
                //               "4",
                //               style: bebasNeue.copyWith(fontSize: 18.spMin),
                //             ),
                //             Text(
                //               "Coupon",
                //               style: TextStyle(fontSize: 12.spMin),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.go('/homepage/detail-level', extra: state.datas.level);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: '#696969'.toColor().withValues(alpha: 0.26))),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                                minRadius: 20.w,
                                backgroundColor: primaryColor.withValues(alpha: 0.2),
                                child: Hero(
                                  tag: "level_icon",
                                  child: Image.asset(
                                    "assets/${state.datas.level}.png",
                                    width: 30,
                                  ),
                                )),
                            5.verticalSpacingRadius,
                            Text(
                              state.datas.level,
                              style: bebasNeue.copyWith(fontSize: 18.spMin),
                            ),
                            Text(
                              context.l10n.level,
                              style: TextStyle(fontSize: 12.spMin),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ).animate().slideX(begin: 0.2, end: 0).fadeIn(),
              ],
            );
          } else if (state is DetailMemberFailure) {
            return ErrorBuilderWidget(
              errorMessage: state.message,
              handleReload: () {
                context.read<DetailMemberBloc>().add(DoDetailMember(false));
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
