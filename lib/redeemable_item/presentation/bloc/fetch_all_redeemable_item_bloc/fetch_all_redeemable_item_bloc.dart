import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/entities/redeemable_item_entity.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/usecase/fetch_all_redeemable_item.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'fetch_all_redeemable_item_event.dart';
part 'fetch_all_redeemable_item_state.dart';

class FetchAllRedeemableItemBloc
    extends Bloc<FetchAllRedeemableItemEvent, FetchAllRedeemableItemState> {
  FetchAllRedeemableItemUsecase fetchAllRedeemableItemUsecase;
  FetchAllRedeemableItemBloc(this.fetchAllRedeemableItemUsecase)
      : super(FetchAllRedeemableItemState()) {
    on<DoFetchAllRedeemableItem>((event, emit) async {
      // Jika data telah mencapai batas maksimum, hentikan pemanggilan.
      if (state.reachMax) return;

      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));
      GlobalLoader.show();
      // Panggil use case untuk fetch data
      final response = await fetchAllRedeemableItemUsecase.execute(
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
          final updatedData = List<DatumRedeemableItemEntity>.from(state.datas)
            ..addAll(result.data);
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
