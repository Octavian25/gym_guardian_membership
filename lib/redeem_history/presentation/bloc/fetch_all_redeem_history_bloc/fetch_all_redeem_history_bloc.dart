import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/redeem_history/domain/entities/redeem_history_entity.dart';
import 'package:gym_guardian_membership/redeem_history/domain/usecase/fetch_all_redeem_history.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'fetch_all_redeem_history_event.dart';
part 'fetch_all_redeem_history_state.dart';

class FetchAllRedeemHistoryBloc
    extends Bloc<FetchAllRedeemHistoryEvent, FetchAllRedeemHistoryState> {
  FetchAllRedeemHistoryUsecase fetchAllRedeemableItemUsecase;
  FetchAllRedeemHistoryBloc(this.fetchAllRedeemableItemUsecase)
      : super(FetchAllRedeemHistoryState()) {
    on<DoFetchAllRedeemHistory>((event, emit) async {
      // Jika data telah mencapai batas maksimum, hentikan pemanggilan.
      if (state.reachMax) return;

      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));
      GlobalLoader.show();
      // Panggil use case untuk fetch data
      final response = await fetchAllRedeemableItemUsecase.execute(
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
            isReachMax = event.page == result.meta.totalPages;
          }
          // Gabungkan data baru dengan data sebelumnya
          final updatedData = List<DatumRedeemHistoryEntity>.from(state.datas)..addAll(result.data);
          log("TOTAL DATA BLOC ${result.data.length}", name: "DoFetchAllRedeemableItem");
          emit(state.copyWith(
            isLoading: false,
            isError: false,
            reachMax: isReachMax,
            datas: updatedData,
            paginated: result.data,
            currentPage: event.page,
          ));
        },
      );
      GlobalLoader.hide();
    });
  }
}
