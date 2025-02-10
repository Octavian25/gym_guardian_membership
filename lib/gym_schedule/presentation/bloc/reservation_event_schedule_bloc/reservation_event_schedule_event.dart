part of 'reservation_event_schedule_bloc.dart';

abstract class ReservationEventScheduleEvent {}

class DoReservationEventSchedule extends ReservationEventScheduleEvent {
  final String events;
  final String memberCode;
  DoReservationEventSchedule(this.events, this.memberCode);
}
