import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/detail_attendance_history/presentation/bloc/fetch_activity_member_bloc/fetch_activity_member_bloc.dart';
import 'package:gym_guardian_membership/redeem_history/domain/usecase/cancel_redeem_item.dart';
import 'package:meta/meta.dart';

part 'cancel_redeem_item_event.dart';
part 'cancel_redeem_item_state.dart';

class CancelRedeemItemBloc extends Bloc<CancelRedeemItemEvent, CancelRedeemItemState> {
  CancelRedeemItemUsecase cancelRedeemItemUsecase;
  CancelRedeemItemBloc(this.cancelRedeemItemUsecase) : super(CancelRedeemItemInitial()) {
    on<DoCancelRedeemItem>((event, emit) async {
      emit(CancelRedeemItemLoading());
      var response = await cancelRedeemItemUsecase.execute(event.id);
      response.fold((l) {
        emit(CancelRedeemItemFailure(l.message));
      }, (r) {
        emit(CancelRedeemItemSuccess(r));
      });
    });
  }
}
