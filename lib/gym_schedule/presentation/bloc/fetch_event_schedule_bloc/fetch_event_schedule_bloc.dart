import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/data/models/calendar_event_data.dart'
    as raw_calendar;
import 'package:calendar_view/calendar_view.dart';
import 'package:gym_guardian_membership/gym_schedule/domain/usecase/fetch_event_schedule.dart';
import 'package:meta/meta.dart';

part 'fetch_event_schedule_event.dart';
part 'fetch_event_schedule_state.dart';

class FetchEventScheduleBloc extends Bloc<FetchEventScheduleEvent, FetchEventScheduleState> {
  FetchEventScheduleUsecase fetchEventScheduleUsecase;
  FetchEventScheduleBloc(this.fetchEventScheduleUsecase) : super(FetchEventScheduleInitial()) {
    on<DoFetchEventSchedule>((event, emit) async {
      emit(FetchEventScheduleLoading());
      var response = await fetchEventScheduleUsecase.execute();
      response.fold((l) {
        emit(FetchEventScheduleFailure(l.message));
      }, (r) {
        emit(FetchEventScheduleSuccess(
            r
                .map((e) => CalendarEventData(
                    title: e.title,
                    date: e.date,
                    color: e.color,
                    description: e.description,
                    descriptionStyle: e.descriptionStyle,
                    endDate: e.endDate,
                    endTime: e.endTime,
                    event: {
                      "event": e.event,
                      "maxQuota": e.maxQuota ?? 0,
                      "availableQuota": e.availableQuota ?? 0,
                      "reservations": e.reservations ?? 0,
                      "reservation_members": e.reservationMembers ?? [],
                      "booked": e.reservationMembers?.contains(event.memberCode)
                    },
                    recurrenceSettings: e.recurrenceSettings != null
                        ? RecurrenceSettings(
                            startDate: e.recurrenceSettings!.startDate,
                            endDate: e.recurrenceSettings!.endDate,
                            excludeDates: e.recurrenceSettings!.excludeDates,
                            frequency: e.recurrenceSettings!.frequency,
                            occurrences: e.recurrenceSettings!.occurrences,
                            recurrenceEndOn: e.recurrenceSettings!.recurrenceEndOn,
                            weekdays: e.recurrenceSettings!.weekdays)
                        : null,
                    startTime: e.startTime,
                    titleStyle: e.titleStyle))
                .toList(),
            r));
      });
    });
  }
}
