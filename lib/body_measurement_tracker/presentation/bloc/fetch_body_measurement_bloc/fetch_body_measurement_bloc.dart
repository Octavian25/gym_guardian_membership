import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/domain/usecase/fetch_body_measurement.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:meta/meta.dart';

part 'fetch_body_measurement_event.dart';
part 'fetch_body_measurement_state.dart';

class FetchBodyMeasurementBloc extends Bloc<FetchBodyMeasurementEvent, FetchBodyMeasurementState> {
  FetchBodyMeasurementUsecase fetchBodyMeasurementUsecase;
  FetchBodyMeasurementBloc(this.fetchBodyMeasurementUsecase)
      : super(FetchBodyMeasurementInitial()) {
    on<DoFetchBodyMeasurement>((event, emit) async {
      emit(FetchBodyMeasurementLoading());
      var response = await fetchBodyMeasurementUsecase.execute(event.memberCode);
      response.fold((l) {
        emit(FetchBodyMeasurementFailure(l.message));
      }, (r) {
        emit(FetchBodyMeasurementSuccess(r));
      });
    });
  }
}
