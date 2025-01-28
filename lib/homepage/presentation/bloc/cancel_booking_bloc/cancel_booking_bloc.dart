import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/cancel_booking.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'cancel_booking_event.dart';
part 'cancel_booking_state.dart';

class CancelBookingBloc extends Bloc<CancelBookingEvent, CancelBookingState> {
  CancelBookingUsecase cancelBookingUsecase;
  CancelBookingBloc(this.cancelBookingUsecase) : super(CancelBookingInitial()) {
    on<DoCancelBooking>((event, emit) async {
      emit(CancelBookingLoading());
      GlobalLoader.show();
      var response = await cancelBookingUsecase.execute(event.id);
      response.fold((l) {
        emit(CancelBookingFailure(l.message));
      }, (r) {
        emit(CancelBookingSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
