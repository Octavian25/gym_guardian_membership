part of 'request_booking_bloc.dart';

abstract class RequestBookingEvent {}

class DoRequestBooking extends RequestBookingEvent {
  final String memberCode;
  final String bookingDate;

  DoRequestBooking(this.bookingDate, this.memberCode);
}
