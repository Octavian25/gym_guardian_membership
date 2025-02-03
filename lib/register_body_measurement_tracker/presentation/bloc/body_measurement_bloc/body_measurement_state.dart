part of 'body_measurement_bloc.dart';

@immutable
sealed class BodyMeasurementState {}

final class BodyMeasurementInitial extends BodyMeasurementState {}

class BodyMeasurementLoading extends BodyMeasurementState {}

class BodyMeasurementSuccess extends BodyMeasurementState {
  final BodyMeasurementEntity datas;
  BodyMeasurementSuccess(this.datas);
}

class BodyMeasurementFailure extends BodyMeasurementState {
  final String message;
  BodyMeasurementFailure(this.message);
}
