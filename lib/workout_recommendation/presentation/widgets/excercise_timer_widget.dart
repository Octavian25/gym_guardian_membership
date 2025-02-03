import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/show_bottom_dialog.dart';
import 'package:gym_guardian_membership/workout_recommendation/data/models/exercise_model.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/widgets/countdown_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class ExcerciseTimerWidget extends StatefulWidget {
  final ExerciseModel exerciseModel;
  const ExcerciseTimerWidget({super.key, required this.exerciseModel});

  @override
  State<ExcerciseTimerWidget> createState() => _ExcerciseTimerWidgetState();
}

class _ExcerciseTimerWidgetState extends State<ExcerciseTimerWidget> {
  List<bool> sets = [];
  int progress = 0;
  @override
  void initState() {
    super.initState();
    sets = List.generate(
      widget.exerciseModel.sets,
      (index) => false,
    );
  }

  GlobalKey<RestCountdownWidgetState> setKey = GlobalKey();
  GlobalKey<RestCountdownWidgetState> restKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          10.verticalSpacingRadius,
          Image.asset(
            "assets/workout.png",
            width: 0.45.sw,
          ),
          10.verticalSpacingRadius,
          Text(
            "SEMANGAT !!",
            style: bebasNeue.copyWith(fontSize: 25.spMin),
          ),
          SizedBox(
            width: 0.8.sw,
            child: Text(
              "Jika anda merasa lelah, segera istirahat dan jangan paksakan tubuh anda",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.spMin, color: Colors.black54),
            ),
          ),
          10.verticalSpacingRadius,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20.w,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sports_gymnastics),
                  Text(
                    "${sets.where((e) => e == false).length}",
                    style: bebasNeue.copyWith(fontSize: 30.spMin),
                  ),
                  Text(
                    "Set",
                    style: TextStyle(fontSize: 10.spMin),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.repeat_outlined),
                  Text(
                    "${widget.exerciseModel.repsPerSet}",
                    style: bebasNeue.copyWith(fontSize: 30.spMin),
                  ),
                  Text(
                    "Repetisi",
                    style: TextStyle(fontSize: 10.spMin),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer_outlined),
                  Text(
                    "${widget.exerciseModel.restBetweenReps}",
                    style: bebasNeue.copyWith(fontSize: 30.spMin),
                  ),
                  Text(
                    "Repetisi",
                    style: TextStyle(fontSize: 10.spMin),
                  ),
                ],
              ),
            ],
          ),
          10.verticalSpacingRadius,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.exerciseModel.restBetweenSets}",
                    style: bebasNeue.copyWith(fontSize: 25.spMin),
                  ),
                  5.horizontalSpaceRadius,
                  Icon(Icons.pause_circle_outline_rounded),
                ],
              ),
              Text(
                "Istirahat Per Set",
                style: TextStyle(fontSize: 10.spMin),
              ),
            ],
          ),
          10.verticalSpacingRadius,
          LayoutBuilder(
            builder: (context, constraints) {
              var showSet = sets[progress];
              if (!showSet) {
                return RestCountdownWidget(
                  key: setKey,
                  title: "Set ${progress + 1}",
                  initialTimeInSeconds:
                      (widget.exerciseModel.restBetweenReps * widget.exerciseModel.repsPerSet),
                  onTimerComplete: () {
                    setState(() {
                      sets[progress] = true;
                    });
                    showBottomDialogueAlert(
                      imagePath: "assets/history2.png",
                      title: "Waktunya Istirahat",
                      subtitle: "Istirahat Akan Dimulai Dalam",
                      duration: 3,
                      onTimerComplete: () {
                        restKey.currentState?.startCountdown();
                      },
                    );
                  },
                );
              }
              return RestCountdownWidget(
                key: restKey,
                title: "Istirahat Set ${progress + 1}",
                initialTimeInSeconds: widget.exerciseModel.restBetweenSets,
                onTimerComplete: () {
                  setState(() {
                    progress++;
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
