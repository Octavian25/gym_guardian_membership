import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';

part 'body_measurement_event.dart';
part 'body_measurement_state.dart';

class BodyMeasurementBloc extends Bloc<BodyMeasurementEvent, BodyMeasurementState> {
  BodyMeasurementBloc() : super(BodyMeasurementInitial()) {
    on<DoBodyMeasurement>((event, emit) async {
      emit(BodyMeasurementSuccess(event.bodyMeasurementEntity));
    }, transformer: debounce(1.seconds));
  }
}
