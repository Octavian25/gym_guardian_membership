import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/logout_member.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

part 'logout_member_event.dart';
part 'logout_member_state.dart';

class LogoutMemberBloc extends Bloc<LogoutMemberEvent, LogoutMemberState> {
  LogoutMemberUsecase logoutMemberUsecase;
  SharedPreferences pref;
  LogoutMemberBloc(this.logoutMemberUsecase, this.pref) : super(LogoutMemberInitial()) {
    on<DoLogoutMember>((event, emit) async {
      emit(LogoutMemberLoading());
      var userIdString = pref.getString(userIdKey);
      var refreshTokenString = pref.getString(refreshToken);
      if (userIdString == null || refreshTokenString == null) {
        return;
      }
      var response = await logoutMemberUsecase.execute(userIdString, refreshTokenString);
      response.fold((l) {
        emit(LogoutMemberFailure(l.message));
      }, (r) {
        pref.clear();
        emit(LogoutMemberSuccess(r));
      });
    });
    on<DoForceLogout>((event, emit) async {
      emit(LogoutMemberLoading());
      var response = await logoutMemberUsecase.execute(event.memberEmail, "-");
      response.fold((l) {
        emit(LogoutMemberFailure(l.message));
      }, (r) {
        pref.clear();
        emit(LogoutMemberSuccess(r));
      });
    });
  }
}
