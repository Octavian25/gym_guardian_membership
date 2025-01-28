import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/register/domain/entities/register_request_entity.dart';
import 'package:gym_guardian_membership/register/domain/usecase/register_member.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';

import 'package:meta/meta.dart';

part 'register_member_event.dart';
part 'register_member_state.dart';

class RegisterMemberBloc extends Bloc<RegisterMemberEvent, RegisterMemberState> {
  RegisterMemberUsecase registerMemberUsecase;
  RegisterMemberBloc(this.registerMemberUsecase) : super(RegisterMemberInit()) {
    on<DoRegisterMember>((event, emit) async {
      emit(RegisterMemberLoadings());
      GlobalLoader.show();
      var response = await registerMemberUsecase.execute(event.registerRequestEntity);
      response.fold((l) {
        emit(RegisterMemberFailure(l.message));
      }, (r) {
        emit(RegisterMemberSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
