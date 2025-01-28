part of 'fetch_last_three_booking_bloc.dart';

@immutable
sealed class FetchLastThreeBookingState {}

final class FetchLastThreeBookingInitial extends FetchLastThreeBookingState {}

class FetchLastThreeBookingLoading extends FetchLastThreeBookingState {}

class FetchLastThreeBookingSuccess extends FetchLastThreeBookingState {
  final List<DatumBookingEntity> datas;
  FetchLastThreeBookingSuccess(this.datas);
}

class FetchLastThreeBookingFailure extends FetchLastThreeBookingState {
  final String message;
  FetchLastThreeBookingFailure(this.message);
}
