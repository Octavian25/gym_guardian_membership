import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_activity_member_by_code.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'fetch_activity_member_event.dart';
part 'fetch_activity_member_state.dart';

class FetchActivityMemberBloc extends Bloc<FetchActivityMemberEvent, FetchActivityMemberState> {
  final FetchActivityMemberByCodeUsecase fetchActivityMemberByCodeUsecase;

  FetchActivityMemberBloc(this.fetchActivityMemberByCodeUsecase)
      : super(FetchActivityMemberState()) {
    on<DoFetchActivityMember>((event, emit) async {
      // Jika data telah mencapai batas maksimum, hentikan pemanggilan.
      if (state.reachMax) return;

      emit(state.copyWith(isLoading: true, isError: false, errorMessage: ""));
      GlobalLoader.show();
      // Panggil use case untuk fetch data
      final response = await fetchActivityMemberByCodeUsecase.execute(
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
          final updatedData = List<DatumActivityMemberEntity>.from(state.datas)
            ..addAll(result.data);

          emit(state.copyWith(
            isLoading: false,
            isError: false,
            reachMax: isReachMax,
            datas: updatedData,
            paged: result.data,
            currentPage: event.page,
          ));
        },
      );
      GlobalLoader.hide();
    });
  }
}
