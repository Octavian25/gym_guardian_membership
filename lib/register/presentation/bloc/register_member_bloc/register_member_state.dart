part of 'register_member_bloc.dart';

@immutable
sealed class RegisterMemberState {}

class RegisterMemberInit extends RegisterMemberState {}

class RegisterMemberLoadings extends RegisterMemberState {}

class RegisterMemberSuccess extends RegisterMemberState {
  final String datas;
  RegisterMemberSuccess(this.datas);
}

class RegisterMemberFailure extends RegisterMemberState {
  final String message;
  RegisterMemberFailure(this.message);
}
