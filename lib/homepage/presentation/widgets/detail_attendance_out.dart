part of 'widgets.dart';

class DetailAttendanceOutWidget extends StatelessWidget {
  final DatumActivityMemberEntity activityMemberEntity;
  const DetailAttendanceOutWidget({super.key, required this.activityMemberEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              "assets/congrats.png",
              width: 0.4.sw,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true, period: 2.seconds),
                )
                .shimmer(),
          ),
          Center(
            child: Text(
              "${context.l10n.congrats}!",
              style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              "${context.l10n.checkout_message}!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.spMin),
            ),
          ),
          10.verticalSpacingRadius,
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.check_out,
                  style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.w300),
                ),
                5.verticalSpacingRadius,
                Text(
                  formatDateWithTime(activityMemberEntity.inputDate),
                  style: bebasNeue.copyWith(fontSize: 25.spMin, fontWeight: FontWeight.bold),
                ),
                5.verticalSpacingRadius,
              ],
            ),
          ),
          10.verticalSpacingRadius,
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.point_earned,
                  style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.w300),
                ),
                5.verticalSpacingRadius,
                Text(
                  activityMemberEntity.pointsEarned.toString(),
                  style: bebasNeue.copyWith(fontSize: 40.spMin, fontWeight: FontWeight.bold),
                ),
                5.verticalSpacingRadius,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
