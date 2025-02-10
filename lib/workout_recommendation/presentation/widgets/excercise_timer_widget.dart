import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
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
  bool isResting = false;
  @override
  void initState() {
    super.initState();
    sets = List.generate(
      widget.exerciseModel.sets,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          10.verticalSpacingRadius,
          Image.asset(
            "assets/workout.png",
            width: 0.4.sw,
          ),
          10.verticalSpacingRadius,
          SizedBox(
            width: 0.8.sw,
            child: Text(
              widget.exerciseModel.exerciseName,
              textAlign: TextAlign.center,
              style: bebasNeue.copyWith(fontSize: 25.spMin),
            ),
          ),
          5.verticalSpacingRadius,
          SizedBox(
            width: 0.8.sw,
            child: Text(
              context.l10n.exercise_timer_subtitle,
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
                  Icon(
                    Icons.sports_gymnastics,
                    size: 18.spMin,
                  ),
                  5.verticalSpacingRadius,
                  Text(
                    "${sets.where((e) => e == false).length}",
                    style: bebasNeue.copyWith(fontSize: 30.spMin),
                  ),
                  Text(
                    context.l10n.set,
                    style: TextStyle(fontSize: 10.spMin),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.repeat_outlined,
                    size: 18.spMin,
                  ),
                  5.verticalSpacingRadius,
                  Text(
                    "${widget.exerciseModel.repsPerSet}",
                    style: bebasNeue.copyWith(fontSize: 30.spMin),
                  ),
                  Text(
                    context.l10n.repetition,
                    style: TextStyle(fontSize: 10.spMin),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.pause_circle_outline_rounded,
                    size: 18.spMin,
                  ),
                  5.verticalSpacingRadius,
                  Text(
                    "${widget.exerciseModel.restBetweenSets}",
                    style: bebasNeue.copyWith(fontSize: 25.spMin),
                  ),
                  Text(
                    context.l10n.per_set,
                    style: TextStyle(fontSize: 10.spMin),
                  ),
                ],
              ),
            ],
          ),
          10.verticalSpacingRadius,
          LayoutBuilder(
            builder: (context, constraints) {
              if (progress == widget.exerciseModel.sets) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: PrimaryButton(
                    title: context.l10n.finish,
                    onPressed: () {
                      context.pop();
                      showBottomDialogueAlert(
                          imagePath: "assets/congrats.png",
                          title: context.l10n.exercise_finish_title,
                          subtitle:
                              "${context.l10n.your_finish_exercise} ${widget.exerciseModel.exerciseName}. ${context.l10n.amazing}!",
                          duration: 3);
                    },
                  ),
                );
              }
              return RestCountdownWidget(
                key: ValueKey(progress),
                title: "${context.l10n.set} ${progress + 1}",
                initialTimeInSeconds: (widget.exerciseModel.restBetweenReps),
                onTimerComplete: () {
                  setState(() {
                    sets[progress] = true;
                  });
                  showBottomDialogueAlert(
                    imagePath: "assets/rest_workout.png",
                    title: context.l10n.break_dialog_title,
                    subtitle: context.l10n.break_dialog_subtitle,
                    duration: 15,
                    onTimerComplete: () {
                      setState(() {
                        progress++;
                      });
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
