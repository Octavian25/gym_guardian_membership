part of 'widgets.dart';

class DetailAttendancePopupWidget extends StatefulWidget {
  final RegisterAttendanceResponseEntity activityMemberEntity;
  const DetailAttendancePopupWidget({super.key, required this.activityMemberEntity});

  @override
  State<DetailAttendancePopupWidget> createState() => _DetailAttendancePopupWidgetState();
}

class _DetailAttendancePopupWidgetState extends State<DetailAttendancePopupWidget> {
  int countdown = 3;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Timer.periodic(
          1.seconds,
          (timer) {
            if (countdown == 1) {
              timer.cancel();
              context.pop();
            }
            setState(() {
              countdown--;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.activityMemberEntity.attendanceType == "IN")
            Center(
              child: Image.asset(
                "assets/attendance.png",
                width: 0.4.sw,
              ),
            ),
          Center(
            child: Text(
              context.l10n.checkin_info,
              style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              context.l10n.detail_attendance_popup,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.spMin),
            ),
          ),
          10.verticalSpacingRadius,
          if (widget.activityMemberEntity.attendanceType == "IN")
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
                    context.l10n.check_in,
                    style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.w300),
                  ),
                  5.verticalSpacingRadius,
                  Text(
                    formatDateWithTime(widget.activityMemberEntity.inputDate),
                    style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.bold),
                  ),
                  5.verticalSpacingRadius,
                ],
              ),
            ),
          20.verticalSpacingRadius,
          Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 25.h,
                  height: 25.h,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1, end: 0),
                    duration: Duration(seconds: countdown),
                    builder: (context, value, _) => CircularProgressIndicator(
                      value: value,
                      strokeWidth: 5.h,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 25.h,
                  height: 25.h,
                  child: Center(
                    child: Text(
                      "$countdown",
                      style: bebasNeue.copyWith(fontSize: 16.spMin, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          20.verticalSpacingRadius,
        ],
      ),
    );
  }
}
