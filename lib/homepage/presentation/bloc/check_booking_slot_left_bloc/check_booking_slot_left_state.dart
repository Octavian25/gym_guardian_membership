part of 'check_booking_slot_left_bloc.dart';

@immutable
sealed class CheckBookingSlotLeftState {}

final class CheckBookingSlotLeftInitial extends CheckBookingSlotLeftState {}

class CheckBookingSlotLeftLoading extends CheckBookingSlotLeftState {}

class CheckBookingSlotLeftSuccess extends CheckBookingSlotLeftState {
  final int datas;
  CheckBookingSlotLeftSuccess(this.datas);
}

class CheckBookingSlotLeftFailure extends CheckBookingSlotLeftState {
  final String message;
  CheckBookingSlotLeftFailure(this.message);
}
