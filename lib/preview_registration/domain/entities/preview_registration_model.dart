import 'package:gym_guardian_membership/preview_registration/data/models/preview_registration_model.dart';
import 'package:gym_guardian_membership/pricing_plan/domain/entities/pricing_plan_entity.dart';

class PreviewRegistrationEntity {
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
  String? condition;
  String motivation;
  PricingPlanEntity? selectedPricingPlan;

  PreviewRegistrationEntity(
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

  PreviewRegistrationModel toModel() => PreviewRegistrationModel(
      condition: condition,
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
      selectedPricingPlan: selectedPricingPlan?.toModel());

  setPricingPlan(PricingPlanEntity pricingPlan) {
    selectedPricingPlan = pricingPlan;
  }
}
