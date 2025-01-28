import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/request_booking.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'request_booking_event.dart';
part 'request_booking_state.dart';

class RequestBookingBloc extends Bloc<RequestBookingEvent, RequestBookingState> {
  RequestBookingUsecase requestBookingUsecase;
  RequestBookingBloc(this.requestBookingUsecase) : super(RequestBookingInitial()) {
    on<DoRequestBooking>((event, emit) async {
      emit(RequestBookingLoading());
      GlobalLoader.show();
      var response = await requestBookingUsecase.execute(event.memberCode, event.bookingDate);
      response.fold((l) {
        emit(RequestBookingFailure(l.message));
      }, (r) {
        emit(RequestBookingSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
