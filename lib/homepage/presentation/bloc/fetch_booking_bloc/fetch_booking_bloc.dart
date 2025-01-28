import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/booking_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_booking_member.dart';
import 'package:os_basecode/os_basecode.dart';

part 'fetch_booking_event.dart';
part 'fetch_booking_state.dart';

class FetchBookingBloc extends Bloc<FetchBookingEvent, FetchBookingState> {
  FetchBookingUsecase fetchBookingUsecase;
  FetchBookingBloc(this.fetchBookingUsecase) : super(FetchBookingState()) {
    on<DoFetchBooking>((event, emit) async {
      // Jika data telah mencapai batas maksimum, hentikan pemanggilan.
      if (!event.forceFetch) {
        if (state.reachMax) return;
      }
      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));

      // Panggil use case untuk fetch data
      final response = await fetchBookingUsecase.execute(
        event.memberCode,
        event.page,
        event.limit,
      );

      response.fold(
        (failure) {
          // Emit jika terjadi error
          emit(state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: failure.message,
          ));
        },
        (result) {
          var isReachMax = false;
          if (event.limit == null) {
            isReachMax = true;
          } else {
            isReachMax = result.data.length < event.limit!;
          }
          debugPrint(result.data.toString());
          // Gabungkan data baru dengan data sebelumnya
          final updatedData = List<DatumBookingEntity>.from(state.datas)..addAll(result.data);

          emit(state.copyWith(
            isLoading: false,
            isError: false,
            reachMax: isReachMax,
            datas: updatedData,
            currentPage: event.page,
          ));
        },
      );
    });
  }
}
