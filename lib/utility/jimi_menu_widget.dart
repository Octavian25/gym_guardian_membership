import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/workout_suggestions_bloc/workout_suggestions_bloc.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/pages/preview_registration_screen.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/register/domain/entities/member_entity.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class JimiMenuWidget extends StatefulWidget {
  const JimiMenuWidget({
    super.key,
  });

  @override
  State<JimiMenuWidget> createState() => _JimiMenuWidgetState();
}

class _JimiMenuWidgetState extends State<JimiMenuWidget> {
  void handleGenerateWeeklySchedule(
    MemberEntity memberEntity,
  ) {
    String gymEquipment = getGymEquipment(context);
    PreviewRegistrationEntity previewRegistrationEntity = PreviewRegistrationEntity(
        emailAddress: memberEntity.memberEmail,
        password: "-",
        fullName: memberEntity.memberName,
        phoneNumber: memberEntity.noHandphone,
        selectedPricingPlan: null,
        gender: memberEntity.gender,
        activityLevel: memberEntity.activityLevel,
        workoutPreference: memberEntity.workoutPreferences.join(","),
        age: memberEntity.age,
        goal: memberEntity.fitnessGoal,
        height: memberEntity.height,
        motivation: memberEntity.fitnessGoal,
        specialCondition: memberEntity.specialCondition,
        weight: memberEntity.weight,
        workoutAt: memberEntity.availableTime,
        workoutDuration: memberEntity.workoutDuration);
    context
        .read<WorkoutSuggestionsBloc>()
        .add(DoWorkoutSuggestions(previewRegistrationEntity, null, gymEquipment));
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   useSafeArea: true,
    //   showDragHandle: true,
    //   backgroundColor: Colors.white,
    //   builder: (context) {
    //     return WorkoutSuggestionResultWidget(
    //         data: previewRegistrationEntity,
    //         handleReCreate: (customPromp) async {
    //           SharedPreferences preferences = await SharedPreferences.getInstance();
    //           preferences.remove("lastGeneratedResult");
    //           if (!context.mounted) return;
    //           context
    //               .read<WorkoutSuggestionsBloc>()
    //               .add(DoWorkoutSuggestions(previewRegistrationEntity, customPromp, gymEquipment));
    //         });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<DetailMemberBloc, DetailMemberState>(
        builder: (context, state) {
          if (state is DetailMemberSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    "assets/ai.png",
                    width: 0.35.sw,
                  ),
                ),
                10.verticalSpacingRadius,
                Center(
                  child: Text(
                    "JIVA – Smart Workout Assistant ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
                  ),
                ),
                5.verticalSpacingRadius,
                Center(
                  child: Text(
                    "Optimalkan latihan Anda dengan JIVA!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.spMin, color: Colors.black54),
                  ),
                ),
                15.verticalSpacingRadius,
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.calendar_month_rounded),
                  title: Text(
                    "Buat Jadwal Seminggu Kedepan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Rencana latihan otomatis sesuai kebutuhan Anda.",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.spMin),
                  ),
                  onTap: () {
                    handleGenerateWeeklySchedule(state.datas);
                  },
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.directions_run_rounded),
                  title: Text(
                    "Rekomendasi Workout",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Jenis olahraga, alat, repetisi, dan durasi terbaik berdasarkan riwayat latihan.",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.spMin),
                  ),
                  onTap: () {
                    if (context.canPop()) context.pop();
                    context.go("/workout-assistance");
                  },
                ),
                20.verticalSpacingRadius,
                PrimaryButton(
                    title: "TUTUP",
                    onPressed: () {
                      context.pop();
                    }),
                10.verticalSpacingRadius,
              ],
            );
          } else if (state is DetailMemberFailure) {
            return ErrorBuilderWidget(
              errorMessage: state.message,
              handleReload: () {
                context.read<DetailMemberBloc>().add(DoDetailMember(false));
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
