import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/domain/usecase/cancel_reservation_event_schedule.dart';
import 'package:meta/meta.dart';

part 'cancel_reservation_event_schedule_event.dart';
part 'cancel_reservation_event_schedule_state.dart';

class CancelReservationEventScheduleBloc
    extends Bloc<CancelReservationEventScheduleEvent, CancelReservationEventScheduleState> {
  CancelReservationEventScheduleUsecase cancelReservationEventScheduleUsecase;
  CancelReservationEventScheduleBloc(this.cancelReservationEventScheduleUsecase)
      : super(CancelReservationEventScheduleInitial()) {
    on<DoCancelReservationEventSchedule>((event, emit) async {
      emit(CancelReservationEventScheduleLoading());
      var response =
          await cancelReservationEventScheduleUsecase.execute(event.memberCode, event.events);
      response.fold((l) {
        emit(CancelReservationEventScheduleFailure(l.message));
      }, (r) {
        emit(CancelReservationEventScheduleSuccess(r));
      });
    });
  }
}
