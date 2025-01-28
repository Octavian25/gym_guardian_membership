part of 'cancel_booking_bloc.dart';

@immutable
sealed class CancelBookingState {}

final class CancelBookingInitial extends CancelBookingState {}

class CancelBookingLoading extends CancelBookingState {}

class CancelBookingSuccess extends CancelBookingState {
  final String datas;
  CancelBookingSuccess(this.datas);
}

class CancelBookingFailure extends CancelBookingState {
  final String message;
  CancelBookingFailure(this.message);
}
