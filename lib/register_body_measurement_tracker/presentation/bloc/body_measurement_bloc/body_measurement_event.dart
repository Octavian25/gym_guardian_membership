part of 'body_measurement_bloc.dart';

abstract class BodyMeasurementEvent {}

class DoBodyMeasurement extends BodyMeasurementEvent {
  BodyMeasurementEntity bodyMeasurementEntity;

  DoBodyMeasurement(this.bodyMeasurementEntity);
}
