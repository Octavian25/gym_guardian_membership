part of 'cancel_booking_bloc.dart';

abstract class CancelBookingEvent {}

class DoCancelBooking extends CancelBookingEvent {
  final String id;
  DoCancelBooking(this.id);
}
