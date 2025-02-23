part of 'widgets.dart';

class DetailBookingWidget extends StatelessWidget {
  final DatumBookingEntity datumBookingEntity;
  const DetailBookingWidget({super.key, required this.datumBookingEntity});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CancelBookingBloc, CancelBookingState>(
      listener: (context, state) {
        if (state is CancelBookingSuccess) {
          var memberState = context.read<DetailMemberBloc>().state;
          if (memberState is DetailMemberSuccess) {
            context
                .read<FetchLastThreeBookingBloc>()
                .add(DoFetchLastThreeBooking(memberState.datas.memberCode, 1, 3));
            context.pop();
            context.pop();
            showBottomDialogueAlert(
                buildContext: parentKey.currentContext!,
                imagePath: "assets/congrats.png", // Consider a more positive image
                title: context.l10n.cancel_booking_dialogue_tilte, // Added exclamation mark
                subtitle:
                    context.l10n.cancel_booking_dialogue_subtitle, // More concise and friendly
                duration: 5);
          }
        } else if (state is CancelBookingFailure) {
          showError(state.message, context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                "assets/history.png",
                width: 0.4.sw,
              ),
            ),
            Center(
              child: Text(
                context.l10n.reservation_info, // More concise
                style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                context.l10n.detail_booking_subtitle, // More concise and friendly
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.spMin),
              ),
            ),
            10.verticalSpacingRadius,
            Container(
              width: 1.sw,
              decoration: BoxDecoration(
                  border: Border.all(color: '#696969'.toColor().withValues(alpha: 0.26)),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.only(top: 5.h, left: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.date,
                    style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.w300),
                  ),
                  5.verticalSpacingRadius,
                  Text(
                    formatDate(datumBookingEntity.inputDate),
                    style: bebasNeue.copyWith(fontSize: 23.spMin, fontWeight: FontWeight.bold),
                  ),
                  5.verticalSpacingRadius,
                ],
              ),
            ),
            10.verticalSpacingRadius,
            Center(
                child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () async {
                      await showDialog(
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
                                context.l10n.cancel_booking_title, // More friendly and concise
                                style: bebasNeue.copyWith(fontSize: 25.spMin),
                              ),
                              5.verticalSpacingRadius,
                              Text(
                                context.l10n.cancel_booking_subtitle, // More friendly and concise
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
                                  dialogContext.pop();
                                },
                                child: Text(context
                                    .l10n.cancel_booking_negative)), // More friendly and concise
                            TextButton(
                                style: TextButton.styleFrom(foregroundColor: Colors.red),
                                onPressed: () {
                                  context
                                      .read<CancelBookingBloc>()
                                      .add(DoCancelBooking(datumBookingEntity.id));
                                },
                                child: Text(context
                                    .l10n.cancel_booking_positive)) // More friendly and concise
                          ],
                        ),
                      );
                      // if (!context.mounted) return;
                      // context.pop();
                    },
                    child: Text(context.l10n.cancel_booking))),
          ],
        ),
      ),
    );
  }
}
