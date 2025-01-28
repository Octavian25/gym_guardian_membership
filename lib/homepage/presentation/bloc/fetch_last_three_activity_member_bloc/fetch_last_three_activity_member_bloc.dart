import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_activity_member_by_code.dart';
import 'package:meta/meta.dart';

part 'fetch_last_three_activity_member_event.dart';
part 'fetch_last_three_activity_member_state.dart';

class FetchLastThreeActivityMemberBloc
    extends Bloc<FetchLastThreeActivityMemberEvent, FetchLastThreeActivityMemberState> {
  FetchActivityMemberByCodeUsecase fetchActivityMemberByCodeUsecase;
  FetchLastThreeActivityMemberBloc(this.fetchActivityMemberByCodeUsecase)
      : super(FetchLastThreeActivityMemberInitial()) {
    on<DoFetchLastThreeActivityMember>((event, emit) async {
      emit(FetchLastThreeActivityMemberLoading());
      var response =
          await fetchActivityMemberByCodeUsecase.execute(event.memberCode, event.page, event.limit);
      response.fold((l) {
        emit(FetchLastThreeActivityMemberFailure(l.message));
      }, (r) {
        emit(FetchLastThreeActivityMemberSuccess(r.data));
      });
    });
  }
}
