part of 'widgets.dart';

class DetailAttendanceWidget extends StatelessWidget {
  final DatumActivityMemberEntity activityMemberEntity;
  const DetailAttendanceWidget({super.key, required this.activityMemberEntity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (activityMemberEntity.attendanceType == "IN")
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
            if (activityMemberEntity.attendanceType == "IN")
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
                      formatDateWithTime(activityMemberEntity.inputDate),
                      style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.bold),
                    ),
                    5.verticalSpacingRadius,
                  ],
                ),
              ),
            10.verticalSpacingRadius,
          ],
        ),
      ),
    );
  }
}
