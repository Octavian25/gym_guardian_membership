import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/usecase/register_body_measurement_tracker.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'register_body_measurement_event.dart';
part 'register_body_measurement_state.dart';

class RegisterBodyMeasurementBloc
    extends Bloc<RegisterBodyMeasurementEvent, RegisterBodyMeasurementState> {
  RegisterBodyMeasurementTrackerUsecase registerBodyMeasurementTrackerUsecase;
  RegisterBodyMeasurementBloc(this.registerBodyMeasurementTrackerUsecase)
      : super(RegisterBodyMeasurementInitial()) {
    on<DoRegisterBodyMeasurement>((event, emit) async {
      GlobalLoader.show();
      emit(RegisterBodyMeasurementLoading());
      var response =
          await registerBodyMeasurementTrackerUsecase.execute(event.bodyMeasurementEntity);
      response.fold((l) {
        emit(RegisterBodyMeasurementFailure(l.message));
      }, (r) {
        emit(RegisterBodyMeasurementSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
