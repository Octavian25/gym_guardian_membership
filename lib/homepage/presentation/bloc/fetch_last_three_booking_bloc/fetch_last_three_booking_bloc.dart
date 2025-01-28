import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/booking_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_booking_member.dart';
import 'package:meta/meta.dart';

part 'fetch_last_three_booking_event.dart';
part 'fetch_last_three_booking_state.dart';

class FetchLastThreeBookingBloc
    extends Bloc<FetchLastThreeBookingEvent, FetchLastThreeBookingState> {
  FetchBookingUsecase fetchBookingUsecase;
  FetchLastThreeBookingBloc(this.fetchBookingUsecase) : super(FetchLastThreeBookingInitial()) {
    on<DoFetchLastThreeBooking>((event, emit) async {
      emit(FetchLastThreeBookingLoading());
      var response = await fetchBookingUsecase.execute(event.memberCode, event.page, event.limit);
      response.fold((l) {
        emit(FetchLastThreeBookingFailure(l.message));
      }, (r) {
        emit(FetchLastThreeBookingSuccess(r.data));
      });
    });
  }
}
