import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/domain/usecase/reservation_event_schedule.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'reservation_event_schedule_event.dart';
part 'reservation_event_schedule_state.dart';

class ReservationEventScheduleBloc
    extends Bloc<ReservationEventScheduleEvent, ReservationEventScheduleState> {
  ReservationEventScheduleUsecase reservationEventScheduleUsecase;
  ReservationEventScheduleBloc(this.reservationEventScheduleUsecase)
      : super(ReservationEventScheduleInitial()) {
    on<DoReservationEventSchedule>((event, emit) async {
      emit(ReservationEventScheduleLoading());
      GlobalLoader.show();
      var response = await reservationEventScheduleUsecase.execute(event.memberCode, event.events);
      response.fold((l) {
        emit(ReservationEventScheduleFailure(l.message));
      }, (r) {
        emit(ReservationEventScheduleSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
