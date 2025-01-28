part of 'login_member_bloc.dart';

@immutable
sealed class LoginMemberState {}

final class LoginMemberInitial extends LoginMemberState {}

class LoginMemberLoadings extends LoginMemberState {}

class LoginMemberSuccess extends LoginMemberState {
  final LoginResponseEntity datas;
  LoginMemberSuccess(this.datas);
}

class LoginMemberFailure extends LoginMemberState {
  final String message;
  LoginMemberFailure(this.message);
}
