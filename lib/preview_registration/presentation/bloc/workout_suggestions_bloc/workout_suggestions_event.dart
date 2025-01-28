part of 'workout_suggestions_bloc.dart';

abstract class WorkoutSuggestionsEvent {}

class DoWorkoutSuggestions extends WorkoutSuggestionsEvent {
  final PreviewRegistrationEntity data;
  final String? customPromp;
  DoWorkoutSuggestions(this.data, this.customPromp);
}
