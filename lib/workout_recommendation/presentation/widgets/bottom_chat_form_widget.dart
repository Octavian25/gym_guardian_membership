import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:os_basecode/os_basecode.dart';

class BottomChatFormWidget extends StatefulWidget {
  final TextEditingController customPromptController;
  final ScrollController scrollController;
  const BottomChatFormWidget(
      {super.key, required this.customPromptController, required this.scrollController});

  @override
  State<BottomChatFormWidget> createState() => _BottomChatFormWidgetState();
}

class _BottomChatFormWidgetState extends State<BottomChatFormWidget> {
  List<String> suggestions = [
    parentKey.currentContext!.l10n.workout_recommendation,
    parentKey.currentContext!.l10n.workout_challenge
  ];
  handleTapShorcut(int indexSelected) async {
    var memberState = context.read<DetailMemberBloc>().state;
    if (memberState is DetailMemberSuccess) {
      var gymEquipment = getGymEquipment(context);
      var lastWeekBodyMeasurementResult = getlastWeekBodyMeasurementData(context);
      if (indexSelected == 0) {
        await getOneWorkoutRecommendation(
            memberState.datas.memberName,
            memberState.datas.age,
            memberState.datas.gender,
            memberState.datas.activityLevel,
            memberState.datas.fitnessGoal,
            memberState.datas.workoutDuration,
            gymEquipment,
            memberState.datas.workoutPreferences.join(','),
            memberState.datas.availableTime,
            memberState.datas.specialCondition,
            null,
            lastWeekBodyMeasurementResult,
            context);
      } else if (indexSelected == 1) {
        await getChallengeWorkout(
            memberState.datas.memberName,
            memberState.datas.age,
            memberState.datas.gender,
            memberState.datas.activityLevel,
            memberState.datas.fitnessGoal,
            memberState.datas.workoutDuration,
            gymEquipment,
            memberState.datas.workoutPreferences.join(','),
            memberState.datas.availableTime,
            memberState.datas.specialCondition,
            null,
            lastWeekBodyMeasurementResult,
            context);
      } else {
        showError("Error Saat Meminta Data Text Cepat", context);
        return;
      }
      if (!mounted) return;
      context.read<ChatHistoryBloc>().add(DoLoadChatHistory());
      FocusManager.instance.primaryFocus?.unfocus();
      widget.scrollController.animateTo(widget.scrollController.position.maxScrollExtent,
          duration: 100.milliseconds, curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 5),
        child: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${context.l10n.quick_chat} : ",
                  style: TextStyle(fontSize: 10.spMin),
                ),
              ),
              5.verticalSpacingRadius,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => 10.horizontalSpaceRadius,
                      scrollDirection: Axis.horizontal,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              handleTapShorcut(index);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Ink(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: primaryColor, borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                suggestions[index],
                                style: TextStyle(
                                    color: "#2D4500".toColor(),
                                    fontSize: 12.spMin,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        );
                      },
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: widget.customPromptController,
                      style: TextStyle(fontSize: 13.spMin),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: context.l10n.write_your_task,
                          border: InputBorder.none),
                    )),
                    10.horizontalSpaceRadius,
                    SizedBox(
                      height: 30.w,
                      width: 30.w,
                      child: IconButton.filled(
                          onPressed: () async {
                            var memberState = context.read<DetailMemberBloc>().state;
                            if (memberState is DetailMemberSuccess) {
                              var gymEquipment = getGymEquipment(context);
                              var lastWeekBodyMeasurementResult =
                                  getlastWeekBodyMeasurementData(context);
                              await getOneWorkoutRecommendation(
                                  memberState.datas.memberName,
                                  memberState.datas.age,
                                  memberState.datas.gender,
                                  memberState.datas.activityLevel,
                                  memberState.datas.fitnessGoal,
                                  memberState.datas.workoutDuration,
                                  gymEquipment,
                                  memberState.datas.workoutPreferences.join(','),
                                  memberState.datas.availableTime,
                                  memberState.datas.specialCondition,
                                  widget.customPromptController.text,
                                  lastWeekBodyMeasurementResult,
                                  context);
                              if (!context.mounted) return;
                              context.read<ChatHistoryBloc>().add(DoLoadChatHistory());
                              FocusManager.instance.primaryFocus?.unfocus();
                              widget.scrollController.animateTo(
                                  widget.scrollController.position.maxScrollExtent,
                                  duration: 500.milliseconds,
                                  curve: Curves.ease);
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            size: 30.w * 0.5,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
