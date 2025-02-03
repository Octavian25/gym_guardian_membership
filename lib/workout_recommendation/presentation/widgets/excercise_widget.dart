import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/expandable_text_widget.dart';
import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
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
                  "Alat Digunakan",
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
                  "Detail Informasi",
                  style: TextStyle(fontSize: 10.spMin),
                ),
                2.verticalSpacingRadius,
                InfoRow(
                  icon: Icons.timer_outlined,
                  title: "Perkiraan Durasi",
                  value: "${exerciseModel.duration} menit",
                ),
                InfoRow(
                  icon: Icons.repeat,
                  title: "Set",
                  value: "${exerciseModel.sets} set",
                ),
                InfoRow(
                  icon: Icons.fitness_center,
                  title: "Repetisi per Set",
                  value: "${exerciseModel.repsPerSet} reps",
                ),
                InfoRow(
                  icon: Icons.pause_circle_outlined,
                  title: "Waktu Per Repetisi",
                  value: "${exerciseModel.restBetweenReps} detik",
                ),
                InfoRow(
                  icon: Icons.pause_circle_outlined,
                  title: "Istirahat Antar Set",
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
                  "Manfaat",
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
                  "Cara Melakukan",
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
                          context: context,
                          builder: (context) {
                            return BlurContainerWrapper(
                              child: YoutubePlayerWidget(exerciseModel: exerciseModel),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Lihat Video Tutorial",
                        style: bebasNeue.copyWith(fontSize: 15.spMin),
                      )),
                ),
                10.horizontalSpaceRadius,
                Expanded(
                  child: FilledButton(
                      style: FilledButton.styleFrom(visualDensity: VisualDensity.compact),
                      onPressed: () {
                        showBlurredBottomSheet(
                          context: context,
                          builder: (context) => BlurContainerWrapper(
                              child: ExcerciseTimerWidget(
                            exerciseModel: exerciseModel,
                          )),
                        );
                      },
                      child: Text(
                        "Mulai Latihan",
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
