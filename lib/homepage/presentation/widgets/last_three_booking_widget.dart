part of 'widgets.dart';

class LastThreeBookingWidget extends StatelessWidget {
  const LastThreeBookingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLastThreeBookingBloc, FetchLastThreeBookingState>(
      builder: (context, state) {
        if (state is FetchLastThreeBookingFailure) {
          return SliverToBoxAdapter(
            child: ErrorBuilderWidget(
              errorMessage: state.message,
              handleReload: () {
                var memberState = context.read<DetailMemberBloc>().state;
                if (memberState is DetailMemberSuccess) {
                  context
                      .read<FetchLastThreeBookingBloc>()
                      .add(DoFetchLastThreeBooking(memberState.datas.memberCode, 1, 3));
                }
              },
            ),
          );
        } else if (state is FetchLastThreeBookingSuccess) {
          if (state.datas.isEmpty) {
            return SliverToBoxAdapter(
                child: EmptyStateWidget(
              title: context.l10n.booking_event_confirm_title, // Translated
              subtitle: context.l10n.booking_event_confirm_subtitle,
            ));
          }

          return SliverList.builder(
            itemCount: state.datas.length > 3 ? 3 : state.datas.length,
            itemBuilder: (context, index) {
              DatumBookingEntity data = state.datas[index];
              return ListTile(
                onTap: () {
                  showBlurredBottomSheet(
                    context: parentKey.currentContext!,
                    builder: (context) {
                      return BlurContainerWrapper(
                        child: DetailBookingWidget(
                          datumBookingEntity: data,
                        ),
                      );
                    },
                  );
                },
                leading: Container(
                  height: 35.h,
                  width: 35.h,
                  decoration: BoxDecoration(
                      color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.confirmation_num_rounded,
                    color: primaryColor,
                  ),
                ),
                trailing: Icon(Icons.chevron_right_outlined),
                title: Text(
                  formatDateWithTime(data.inputDate),
                  style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        } else if (state is FetchLastThreeBookingLoading) {
          return Skeletonizer.sliver(
            child: SliverList.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Container(
                  color: Colors.red,
                  height: 35.h,
                  width: 35.h,
                ),
                title: Text("Skeletonizer Longer Title"),
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
