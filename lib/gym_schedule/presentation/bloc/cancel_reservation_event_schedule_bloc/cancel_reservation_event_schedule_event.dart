part of 'cancel_reservation_event_schedule_bloc.dart';

abstract class CancelReservationEventScheduleEvent {}

class DoCancelReservationEventSchedule extends CancelReservationEventScheduleEvent {
  final String events;
  final String memberCode;
  DoCancelReservationEventSchedule(this.events, this.memberCode);
}
