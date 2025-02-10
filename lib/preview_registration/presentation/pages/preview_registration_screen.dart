import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/data/models/workout_recommendation_model.dart';

import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/preview_registration_bloc/preview_registration_bloc.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/workout_suggestions_bloc/workout_suggestions_bloc.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/pages/term_and_condition.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/widgets/information_detail.dart';
import 'package:gym_guardian_membership/register/domain/entities/register_request_entity.dart';
import 'package:gym_guardian_membership/register/presentation/bloc/register_member_bloc/register_member_bloc.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';

import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class PreviewRegistrationScreen extends StatefulWidget {
  const PreviewRegistrationScreen({super.key});

  @override
  State<PreviewRegistrationScreen> createState() => _PreviewRegistrationScreenState();
}

class _PreviewRegistrationScreenState extends State<PreviewRegistrationScreen> {
  ScrollController scrollController = ScrollController();
  bool acceptTermAndCondition = false;
  @override
  void initState() {
    super.initState();
  }

  void handleRegister() async {
    var previewState = context.read<PreviewRegistrationBloc>().state;
    if (previewState is PreviewRegistrationHasData) {
      RegisterRequestEntity registerRequestEntity = RegisterRequestEntity(
          memberName: previewState.previewRegistrationEntity.fullName,
          memberEmail: previewState.previewRegistrationEntity.emailAddress,
          noHandphone: previewState.previewRegistrationEntity.phoneNumber,
          password: previewState.previewRegistrationEntity.password,
          packageCode: previewState.previewRegistrationEntity.selectedPricingPlan!.packageCode,
          activityLevel: previewState.previewRegistrationEntity.activityLevel,
          age: previewState.previewRegistrationEntity.age,
          weight: previewState.previewRegistrationEntity.weight,
          height: previewState.previewRegistrationEntity.height,
          availableTime: previewState.previewRegistrationEntity.workoutAt,
          fitnessGoal: previewState.previewRegistrationEntity.goal,
          workoutDuration: previewState.previewRegistrationEntity.workoutDuration,
          gender: previewState.previewRegistrationEntity.gender,
          specialCondition:
              "${previewState.previewRegistrationEntity.specialCondition} - ${previewState.previewRegistrationEntity.condition}",
          workoutPreferences: [previewState.previewRegistrationEntity.workoutPreference]);
      context.read<RegisterMemberBloc>().add(DoRegisterMember(registerRequestEntity));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutSuggestionsBloc, WorkoutSuggestionsState>(
      listener: (context, state) {
        if (state is WorkoutSuggestionsSuccess) {}
      },
      child: Scaffold(
        body: BlocListener<RegisterMemberBloc, RegisterMemberState>(
          listener: (context, state) {
            if (state is RegisterMemberSuccess) {
              context.go("/login");
              showSuccess(state.datas, context);
              return;
            } else if (state is RegisterMemberFailure) {
              showError(state.message, context);
              return;
            }
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    context.l10n.preview_registration_data_title,
                    style: bebasNeue.copyWith(fontSize: 30.spMin),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    context.l10n.preview_registration_data_subtitle,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: 23.verticalSpacingRadius),
              baseSliverPadding(
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<PreviewRegistrationBloc, PreviewRegistrationState>(
                    builder: (context, state) {
                      if (state is PreviewRegistrationHasData) {
                        PreviewRegistrationEntity data = state.previewRegistrationEntity;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.full_name,
                                    value: data.fullName,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.phone_number,
                                    value: data.phoneNumber,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.gender,
                                    value: data.gender,
                                  ),
                                )
                              ],
                            ),
                            InformationDetail(title: context.l10n.email, value: data.emailAddress),
                            Row(
                              children: [
                                Expanded(
                                    child: InformationDetail(
                                        title: context.l10n.age, value: data.age.toString())),
                                Expanded(
                                    child: InformationDetail(
                                        title: context.l10n.height, value: data.height.toString())),
                                Expanded(
                                    child: InformationDetail(
                                        title: context.l10n.weight, value: data.weight.toString()))
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.goals,
                                    value: data.goal,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.activity_level,
                                    value: data.activityLevel,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.workout_preference,
                                    value: data.workoutPreference,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.workout_duration,
                                    value: data.workoutDuration,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.workout_at,
                                    value: data.workoutAt,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.special_condition,
                                    value: data.specialCondition,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                if (data.condition != null)
                                  Expanded(
                                    child: InformationDetail(
                                      title: "${context.l10n.condition} *",
                                      value: data.condition!,
                                    ),
                                  ),
                                Expanded(
                                  child: InformationDetail(
                                    title: context.l10n.motivation,
                                    value: data.motivation,
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Text(
                              context.l10n.selected_plan,
                              style: TextStyle(fontSize: 12.spMin),
                            ),
                            ListTile(
                              splashColor: primaryColor.withValues(alpha: 0.1),
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              title: Text(
                                data.selectedPricingPlan?.packageName ?? "-",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  "${context.l10n.duration} : ${data.selectedPricingPlan?.duration} ${context.l10n.day}"),
                              leading: Icon(
                                Icons.check_circle,
                                color: primaryColor,
                              ),
                              trailing: Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    formatRupiah(data.selectedPricingPlan?.price.toDouble() ?? 0),
                                    style: bebasNeue.copyWith(fontSize: 20.spMin),
                                  )),
                            ),
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              value: acceptTermAndCondition,
                              onChanged: null,
                              title: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: context.l10n.im_agree_with,
                                    style: GoogleFonts.montserrat(color: Colors.black)),
                                TextSpan(
                                    text: " ${context.l10n.term_and_condition}",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var result = await showBlurredBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return BlurContainerWrapper(
                                              child: SizedBox(
                                                  height: 0.8.sh,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16),
                                                    child: TermsAndConditionsScreen(),
                                                  )),
                                            );
                                          },
                                        );
                                        if (result != null && result == true) {
                                          setState(() {
                                            acceptTermAndCondition = true;
                                          });
                                        }
                                      },
                                    style: GoogleFonts.montserrat(
                                        color: primaryColor, fontWeight: FontWeight.bold)),
                              ])),
                            )
                          ],
                        );
                      } else {
                        return Text("We got some error, Please try again later.");
                      }
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: PrimaryButton(
                    title: context.l10n.sign_up,
                    onPressed: acceptTermAndCondition ? handleRegister : null,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: 30.verticalSpacingRadius),
            ],
          ),
        ),
      ),
    );
  }
}
