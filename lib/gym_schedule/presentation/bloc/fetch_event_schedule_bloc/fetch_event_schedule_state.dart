part of 'fetch_event_schedule_bloc.dart';

@immutable
sealed class FetchEventScheduleState {}

final class FetchEventScheduleInitial extends FetchEventScheduleState {}

class FetchEventScheduleLoading extends FetchEventScheduleState {}

class FetchEventScheduleSuccess extends FetchEventScheduleState {
  final List<CalendarEventData> datas;
  final List<raw_calendar.CalendarEventData> rawDatas;
  FetchEventScheduleSuccess(this.datas, this.rawDatas);
}

class FetchEventScheduleFailure extends FetchEventScheduleState {
  final String message;
  FetchEventScheduleFailure(this.message);
}
