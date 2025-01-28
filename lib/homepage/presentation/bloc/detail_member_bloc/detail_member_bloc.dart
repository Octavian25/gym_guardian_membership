import 'dart:developer';

import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_detail_member_by_email.dart';
import 'package:gym_guardian_membership/register/domain/entities/member_entity.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';

part 'detail_member_event.dart';
part 'detail_member_state.dart';

class DetailMemberBloc extends Bloc<DetailMemberEvent, DetailMemberState> {
  FetchDetailMemberByEmailUsecase fetchDetailMemberByEmailUsecase;
  SharedPreferences pref;
  DetailMemberBloc(this.fetchDetailMemberByEmailUsecase, this.pref) : super(DetailMemberInitial()) {
    on<DoDetailMember>((event, emit) async {
      emit(DetailMemberLoading());
      GlobalLoader.show();
      var email = pref.getString(userIdKey);
      if (email == null) {
        emit(DetailMemberFailure("Email not found!"));
        GlobalLoader.hide();
        return;
      }
      var token = pref.getString(accessToken);
      log(
        "INI TOKEN $token",
        name: "TOKEN",
      );
      var response = await fetchDetailMemberByEmailUsecase.execute(email);
      response.fold((l) {
        emit(DetailMemberFailure(l.message));
      }, (r) {
        emit(DetailMemberSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
