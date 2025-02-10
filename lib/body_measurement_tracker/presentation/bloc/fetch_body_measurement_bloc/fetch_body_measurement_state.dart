part of 'fetch_body_measurement_bloc.dart';

@immutable
sealed class FetchBodyMeasurementState {}

final class FetchBodyMeasurementInitial extends FetchBodyMeasurementState {}

class FetchBodyMeasurementLoading extends FetchBodyMeasurementState {}

class FetchBodyMeasurementSuccess extends FetchBodyMeasurementState {
  final List<BodyMeasurementEntity> datas;
  FetchBodyMeasurementSuccess(this.datas);
}

class FetchBodyMeasurementFailure extends FetchBodyMeasurementState {
  final String message;
  FetchBodyMeasurementFailure(this.message);
}
