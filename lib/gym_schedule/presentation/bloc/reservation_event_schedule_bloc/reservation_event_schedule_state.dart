part of 'reservation_event_schedule_bloc.dart';

@immutable
sealed class ReservationEventScheduleState {}

final class ReservationEventScheduleInitial extends ReservationEventScheduleState {}

class ReservationEventScheduleLoading extends ReservationEventScheduleState {}

class ReservationEventScheduleSuccess extends ReservationEventScheduleState {
  final String datas;
  ReservationEventScheduleSuccess(this.datas);
}

class ReservationEventScheduleFailure extends ReservationEventScheduleState {
  final String message;
  ReservationEventScheduleFailure(this.message);
}
