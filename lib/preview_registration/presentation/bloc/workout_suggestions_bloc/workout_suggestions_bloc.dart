import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/data/models/workout_recommendation_model.dart';
import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';

part 'workout_suggestions_event.dart';
part 'workout_suggestions_state.dart';

class WorkoutSuggestionsBloc extends Bloc<WorkoutSuggestionsEvent, WorkoutSuggestionsState> {
  WorkoutSuggestionsBloc() : super(WorkoutSuggestionsInitial()) {
    on<DoWorkoutSuggestions>((event, emit) async {
      emit(WorkoutSuggestionsLoading());
      var data = event.data;
      WorkoutRecommendationModel? result = await getRecommendation(
          data.fullName,
          data.age,
          data.gender,
          data.activityLevel,
          data.goal,
          data.workoutDuration.toInt() ?? 0,
          'Treadmill, Stationary Bike, Dumbbells, Pull-Up Bar,Yoga Mat,Punching Bag',
          data.workoutPreference,
          data.workoutAt,
          data.specialCondition,
          event.customPromp);
      if (result == null) {
        emit(WorkoutSuggestionsFailure("Cannot get recommendations from gemini AI"));
      } else {
        emit(WorkoutSuggestionsSuccess(result, data));
      }
    });
  }
}
