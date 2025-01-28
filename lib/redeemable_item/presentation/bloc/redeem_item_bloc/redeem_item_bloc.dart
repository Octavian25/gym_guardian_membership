import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/usecase/redeem_item.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'redeem_item_event.dart';
part 'redeem_item_state.dart';

class RedeemItemBloc extends Bloc<RedeemItemEvent, RedeemItemState> {
  RedeemItemUsecase redeemItemUsecase;
  RedeemItemBloc(this.redeemItemUsecase) : super(RedeemItemInitial()) {
    on<DoRedeemItem>((event, emit) async {
      emit(RedeemItemLoading());
      GlobalLoader.show();
      var response = await redeemItemUsecase.execute(event.memberCode, event.itemId);
      response.fold((l) {
        emit(RedeemItemFailure(l.message));
      }, (r) {
        emit(RedeemItemSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
