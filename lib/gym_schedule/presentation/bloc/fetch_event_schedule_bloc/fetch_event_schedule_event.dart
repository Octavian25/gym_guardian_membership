part of 'fetch_event_schedule_bloc.dart';

abstract class FetchEventScheduleEvent {}

class DoFetchEventSchedule extends FetchEventScheduleEvent {
  final String memberCode;
  DoFetchEventSchedule(this.memberCode);
}
