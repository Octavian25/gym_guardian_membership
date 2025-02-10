part of 'register_body_measurement_bloc.dart';

@immutable
sealed class RegisterBodyMeasurementState {}

final class RegisterBodyMeasurementInitial extends RegisterBodyMeasurementState {}

class RegisterBodyMeasurementLoading extends RegisterBodyMeasurementState {}

class RegisterBodyMeasurementSuccess extends RegisterBodyMeasurementState {
  final String datas;
  RegisterBodyMeasurementSuccess(this.datas);
}

class RegisterBodyMeasurementFailure extends RegisterBodyMeasurementState {
  final String message;
  RegisterBodyMeasurementFailure(this.message);
}
