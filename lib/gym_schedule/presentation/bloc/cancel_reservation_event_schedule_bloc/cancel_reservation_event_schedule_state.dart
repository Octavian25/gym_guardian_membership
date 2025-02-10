part of 'cancel_reservation_event_schedule_bloc.dart';

@immutable
sealed class CancelReservationEventScheduleState {}

final class CancelReservationEventScheduleInitial extends CancelReservationEventScheduleState {}

class CancelReservationEventScheduleLoading extends CancelReservationEventScheduleState {}

class CancelReservationEventScheduleSuccess extends CancelReservationEventScheduleState {
  final String datas;
  CancelReservationEventScheduleSuccess(this.datas);
}

class CancelReservationEventScheduleFailure extends CancelReservationEventScheduleState {
  final String message;
  CancelReservationEventScheduleFailure(this.message);
}
