part of 'fetch_body_measurement_bloc.dart';

abstract class FetchBodyMeasurementEvent {}

class DoFetchBodyMeasurement extends FetchBodyMeasurementEvent {
  String memberCode;
  DoFetchBodyMeasurement(this.memberCode);
}
