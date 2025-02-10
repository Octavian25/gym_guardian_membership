import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/expandable_text_widget.dart';
import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:gym_guardian_membership/workout_recommendation/data/models/exercise_model.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/widgets/excercise_timer_widget.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/widgets/youtube_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class ExcerciseWidget extends StatelessWidget {
  const ExcerciseWidget({
    super.key,
    required this.exerciseModel,
    required this.chatHistory,
  });

  final ExerciseModel exerciseModel;
  final ChatHistoryModel chatHistory;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              exerciseModel.exerciseName,
              style: bebasNeue.copyWith(fontSize: 20.spMin),
            ),
            5.verticalSpacingRadius,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.tools_used,
                  style: TextStyle(fontSize: 10.spMin),
                ),
                2.verticalSpacingRadius,
                Text(
                  exerciseModel.equipment,
                  style: TextStyle(fontSize: 13.spMin, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            5.verticalSpacingRadius,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.detail_information,
                  style: TextStyle(fontSize: 10.spMin),
                ),
                2.verticalSpacingRadius,
                InfoRow(
                  icon: Icons.timer_outlined,
                  title: context.l10n.estimated_duration,
                  value: "${exerciseModel.duration} menit",
                ),
                InfoRow(
                  icon: Icons.repeat,
                  title: context.l10n.set,
                  value: "${exerciseModel.sets} set",
                ),
                InfoRow(
                  icon: Icons.fitness_center,
                  title: context.l10n.repetition_per_set,
                  value: "${exerciseModel.repsPerSet} reps",
                ),
                InfoRow(
                  icon: Icons.pause_circle_outlined,
                  title: context.l10n.duration_per_repetition,
                  value: "${exerciseModel.restBetweenReps} detik",
                ),
                InfoRow(
                  icon: Icons.pause_circle_outlined,
                  title: context.l10n.rest_per_set,
                  value: "${exerciseModel.restBetweenSets} detik",
                ),
              ],
            ),
            5.verticalSpacingRadius,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.benefits,
                  style: TextStyle(fontSize: 10.spMin),
                ),
                2.verticalSpacingRadius,
                ExpandableText(
                    text: exerciseModel.benefits,
                    maxLines: 3,
                    style: TextStyle(fontSize: 13.spMin, fontWeight: FontWeight.bold))
              ],
            ),
            5.verticalSpacingRadius,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.how_to_do_it,
                  style: TextStyle(fontSize: 10.spMin),
                ),
                2.verticalSpacingRadius,
                ExpandableText(
                    text: exerciseModel.howToDo,
                    maxLines: 3,
                    style: TextStyle(fontSize: 13.spMin, fontWeight: FontWeight.bold))
              ],
            ),
            5.verticalSpacingRadius,
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.red, visualDensity: VisualDensity.compact),
                      onPressed: () {
                        showBlurredBottomSheet(
                          context: parentKey.currentContext!,
                          builder: (context) {
                            return BlurContainerWrapper(
                              child: YoutubePlayerWidget(exerciseModel: exerciseModel),
                            );
                          },
                        );
                      },
                      child: Text(
                        context.l10n.show_video_tutorial,
                        style: bebasNeue.copyWith(fontSize: 15.spMin, color: Colors.white),
                      )),
                ),
                10.horizontalSpaceRadius,
                Expanded(
                  child: FilledButton(
                      style: FilledButton.styleFrom(visualDensity: VisualDensity.compact),
                      onPressed: () {
                        showBlurredBottomSheet(
                          context: parentKey.currentContext!,
                          builder: (context) => BlurContainerWrapper(
                              child: ExcerciseTimerWidget(
                            exerciseModel: exerciseModel,
                          )),
                        );
                      },
                      child: Text(
                        context.l10n.start_workout,
                        style: bebasNeue.copyWith(fontSize: 15.spMin),
                      )),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatDateWithTime(chatHistory.timestamp),
                  style: TextStyle(fontSize: 8.spMin),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.title, required this.value});

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14.spMin,
        ),
        5.horizontalSpaceRadius,
        Text(
          "$title : $value",
          style: TextStyle(fontSize: 13.spMin, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
