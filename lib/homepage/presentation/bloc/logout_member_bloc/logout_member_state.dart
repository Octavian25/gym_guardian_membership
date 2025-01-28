part of 'logout_member_bloc.dart';

@immutable
sealed class LogoutMemberState {}

final class LogoutMemberInitial extends LogoutMemberState {}

class LogoutMemberLoading extends LogoutMemberState {}

class LogoutMemberSuccess extends LogoutMemberState {
  final String datas;
  LogoutMemberSuccess(this.datas);
}

class LogoutMemberFailure extends LogoutMemberState {
  final String message;
  LogoutMemberFailure(this.message);
}
