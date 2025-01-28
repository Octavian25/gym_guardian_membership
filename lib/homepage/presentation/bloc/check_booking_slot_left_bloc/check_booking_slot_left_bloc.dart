import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/check_booking_slot_left.dart';
import 'package:meta/meta.dart';

part 'check_booking_slot_left_event.dart';
part 'check_booking_slot_left_state.dart';

class CheckBookingSlotLeftBloc extends Bloc<CheckBookingSlotLeftEvent, CheckBookingSlotLeftState> {
  CheckBookingSlotLeftUsecase checkBookingSlotLeftUsecase;
  CheckBookingSlotLeftBloc(this.checkBookingSlotLeftUsecase)
      : super(CheckBookingSlotLeftInitial()) {
    on<DoCheckBookingSlotLeft>((event, emit) async {
      emit(CheckBookingSlotLeftLoading());
      var response = await checkBookingSlotLeftUsecase.execute();
      response.fold((l) {
        emit(CheckBookingSlotLeftFailure(l.message));
      }, (r) {
        emit(CheckBookingSlotLeftSuccess(r));
      });
    });
  }
}
