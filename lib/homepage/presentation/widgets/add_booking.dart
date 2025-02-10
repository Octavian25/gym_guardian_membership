part of 'widgets.dart';

class AddBookingWidget extends StatefulWidget {
  const AddBookingWidget({
    super.key,
  });

  @override
  State<AddBookingWidget> createState() => _AddBookingWidgetState();
}

class _AddBookingWidgetState extends State<AddBookingWidget> {
  TextEditingController dateController = TextEditingController(text: formatDate(DateTime.now()));
  String dateString = getDateOnly(DateTime.now());

  void handleBooking() async {
    var memberState = context.read<DetailMemberBloc>().state;
    if (memberState is DetailMemberSuccess) {
      context
          .read<RequestBookingBloc>()
          .add(DoRequestBooking(dateString, memberState.datas.memberCode));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.reservation_service,
            style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
          ),
          Text(
            context.l10n.reservation_service_subtitle,
            style: TextStyle(fontSize: 11.spMin),
          ),
          10.verticalSpacingRadius,
          Container(
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
                TextFormField(
                  controller: dateController,
                  showCursor: false,
                  enabled: false,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: context.l10n.click_calendar_icon,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime? dateSelected = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now(),
                            );
                            if (dateSelected != null) {
                              dateString = getDateOnly(dateSelected);

                              dateController.text = formatDate(dateSelected);
                            }
                          },
                          icon: Icon(Icons.timer_outlined)),
                      contentPadding: EdgeInsets.only(left: 0, top: 0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
                ),
              ],
            ),
          ),
          20.verticalSpacingRadius,
          Text(
            context.l10n.reservation_only_today,
            style: TextStyle(fontSize: 11.spMin),
          ),
          10.verticalSpacingRadius,
          BlocConsumer<RequestBookingBloc, RequestBookingState>(
            listener: (context, state) {
              if (state is RequestBookingSuccess) {
                var memberState = context.read<DetailMemberBloc>().state;
                if (memberState is DetailMemberSuccess) {
                  context
                      .read<FetchLastThreeBookingBloc>()
                      .add(DoFetchLastThreeBooking(memberState.datas.memberCode, 1, 3));
                  context.pop();
                  showBottomDialogueAlert(
                      buildContext: context,
                      imagePath: "assets/congrats.png",
                      title: context.l10n.reservation_success_title,
                      subtitle: context.l10n.reservation_success_subtitle,
                      duration: 5);
                }
              } else if (state is RequestBookingFailure) {
                showError(state.message, context);
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                title: "${context.l10n.reservation_now}!",
                onPressed: state is RequestBookingLoading ? null : handleBooking,
              );
            },
          ),
          20.verticalSpacingRadius,
        ],
      ),
    );
  }
}
