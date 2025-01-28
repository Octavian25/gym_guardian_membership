part of 'request_booking_bloc.dart';

@immutable
sealed class RequestBookingState {}

final class RequestBookingInitial extends RequestBookingState {}

class RequestBookingLoading extends RequestBookingState {}

class RequestBookingSuccess extends RequestBookingState {
  final String datas;
  RequestBookingSuccess(this.datas);
}

class RequestBookingFailure extends RequestBookingState {
  final String message;
  RequestBookingFailure(this.message);
}
