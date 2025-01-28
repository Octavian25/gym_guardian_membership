import 'package:gym_guardian_membership/login/domain/entities/login_response_entity.dart';
import 'package:gym_guardian_membership/login/domain/usecase/login_member.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';

part 'login_member_event.dart';
part 'login_member_state.dart';

class LoginMemberBloc extends Bloc<LoginMemberEvent, LoginMemberState> {
  LoginMemberUsecase loginMemberUsecase;
  LoginMemberBloc(this.loginMemberUsecase) : super(LoginMemberInitial()) {
    on<DoLoginMember>((event, emit) async {
      emit(LoginMemberLoadings());
      GlobalLoader.show();
      var response = await loginMemberUsecase.execute(event.userId, event.password);
      response.fold((l) {
        emit(LoginMemberFailure(l.message));
      }, (r) {
        emit(LoginMemberSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
