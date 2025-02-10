part of 'register_body_measurement_bloc.dart';

abstract class RegisterBodyMeasurementEvent {}

class DoRegisterBodyMeasurement extends RegisterBodyMeasurementEvent {
  final BodyMeasurementEntity bodyMeasurementEntity;
  DoRegisterBodyMeasurement(this.bodyMeasurementEntity);
}
