part of 'workout_suggestions_bloc.dart';

abstract class WorkoutSuggestionsEvent {}

class DoWorkoutSuggestions extends WorkoutSuggestionsEvent {
  final PreviewRegistrationEntity data;
  final String? customPromp;
  final String gymEquipments;
  DoWorkoutSuggestions(this.data, this.customPromp, this.gymEquipments);
}

class DoCancelWorkoutSuggestions extends WorkoutSuggestionsEvent {}
