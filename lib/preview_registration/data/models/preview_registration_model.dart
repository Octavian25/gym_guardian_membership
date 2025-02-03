import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:gym_guardian_membership/pricing_plan/data/models/pricing_plan_model.dart';

class PreviewRegistrationModel {
  String fullName;
  String phoneNumber;
  String emailAddress;
  String password;
  String gender;
  int height;
  int weight;
  int age;
  String goal;
  String activityLevel;
  String workoutPreference;
  String workoutDuration;
  String workoutAt;
  String specialCondition;
  String motivation;
  String? condition;
  PricingPlanModel? selectedPricingPlan;

  PreviewRegistrationModel(
      {required this.emailAddress,
      required this.password,
      required this.fullName,
      required this.phoneNumber,
      required this.selectedPricingPlan,
      required this.gender,
      required this.activityLevel,
      required this.workoutPreference,
      required this.age,
      required this.goal,
      required this.height,
      required this.motivation,
      required this.specialCondition,
      required this.weight,
      required this.workoutAt,
      this.condition,
      required this.workoutDuration});

  PreviewRegistrationEntity toModel() => PreviewRegistrationEntity(
      activityLevel: activityLevel,
      age: age,
      gender: gender,
      goal: goal,
      height: height,
      motivation: motivation,
      specialCondition: specialCondition,
      weight: weight,
      workoutAt: workoutAt,
      workoutDuration: workoutDuration,
      workoutPreference: workoutPreference,
      emailAddress: emailAddress,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      condition: condition,
      selectedPricingPlan: selectedPricingPlan?.toEntity());

  setPricingPlan(PricingPlanModel pricingPlan) {
    selectedPricingPlan = pricingPlan;
  }
}
