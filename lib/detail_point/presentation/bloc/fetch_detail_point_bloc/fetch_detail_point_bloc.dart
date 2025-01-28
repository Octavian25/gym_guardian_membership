import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:gym_guardian_membership/detail_point/domain/usecase/fetch_point_history_by_code.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'fetch_detail_point_event.dart';
part 'fetch_detail_point_state.dart';

class FetchDetailPointBloc extends Bloc<FetchDetailPointEvent, FetchDetailPointState> {
  final FetchPointHistoyByCodeUsecase fetchPointHistoyByCodeUsecase;

  FetchDetailPointBloc(this.fetchPointHistoyByCodeUsecase) : super(FetchDetailPointState()) {
    on<DoFetchDetailPoint>(_onFetchDetailPoint);
  }

  Future<void> _onFetchDetailPoint(
    DoFetchDetailPoint event,
    Emitter<FetchDetailPointState> emit,
  ) async {
    try {
      // Jika telah mencapai batas maksimum, hentikan pemanggilan.
      if (state.reachMax) return;

      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));
      GlobalLoader.show();
      // Panggil use case untuk fetch data
      final response = await fetchPointHistoyByCodeUsecase.execute(
        event.memberCode,
        event.page ?? 1,
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
          // Periksa apakah data sudah mencapai batas maksimum
          final isReachMax = result.data.isEmpty || result.meta.totalPages == (event.page ?? 0);

          // Filter data untuk menghindari duplikasi
          final newData = result.data.where((item) => !state.datas.contains(item)).toList();

          // Gabungkan data baru dengan data sebelumnya
          final updatedData = List<DatumPointHistoryEntity>.from(state.datas)..addAll(newData);
          emit(state.copyWith(
            isLoading: false,
            isError: false,
            reachMax: isReachMax,
            datas: updatedData,
            paged: result.data,
            currentPage: (event.page ?? 1) + 1,
          ));
        },
      );
      GlobalLoader.hide();
    } catch (e) {
      GlobalLoader.hide();
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }
}
