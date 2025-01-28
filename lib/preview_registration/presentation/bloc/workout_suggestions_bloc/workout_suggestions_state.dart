part of 'workout_suggestions_bloc.dart';

@immutable
sealed class WorkoutSuggestionsState {}

final class WorkoutSuggestionsInitial extends WorkoutSuggestionsState {}

class WorkoutSuggestionsLoading extends WorkoutSuggestionsState {}

class WorkoutSuggestionsSuccess extends WorkoutSuggestionsState {
  final WorkoutRecommendationModel datas;
  final PreviewRegistrationEntity previewData;
  WorkoutSuggestionsSuccess(this.datas, this.previewData);
}

class WorkoutSuggestionsFailure extends WorkoutSuggestionsState {
  final String message;
  WorkoutSuggestionsFailure(this.message);
}
