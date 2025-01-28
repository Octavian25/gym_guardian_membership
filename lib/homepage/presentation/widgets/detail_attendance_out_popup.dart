part of 'widgets.dart';

class DetailAttendanceOutPopupWidget extends StatefulWidget {
  final RegisterAttendanceResponseEntity activityMemberEntity;
  const DetailAttendanceOutPopupWidget({super.key, required this.activityMemberEntity});

  @override
  State<DetailAttendanceOutPopupWidget> createState() => _DetailAttendanceOutPopupWidgetState();
}

class _DetailAttendanceOutPopupWidgetState extends State<DetailAttendanceOutPopupWidget>
    with SingleTickerProviderStateMixin {
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
              "Selamat!", // Translated
              style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              "Teruslah berlatih untuk mencapai level berikutnya!", // Translated and improved
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
                  "Check Out",
                  style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.w300),
                ),
                5.verticalSpacingRadius,
                Text(
                  formatDateWithTime(widget.activityMemberEntity.inputDate),
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
                  "Poin yang Didapatkan", // Translated
                  style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.w300),
                ),
                5.verticalSpacingRadius,
                Text(
                  widget.activityMemberEntity.pointsEarned.toString(),
                  style: bebasNeue.copyWith(fontSize: 40.spMin, fontWeight: FontWeight.bold),
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
