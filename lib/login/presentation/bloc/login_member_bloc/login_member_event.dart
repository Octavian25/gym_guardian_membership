part of 'login_member_bloc.dart';

@immutable
sealed class LoginMemberEvent {}

class DoLoginMember extends LoginMemberEvent {
  final String userId;
  final String password;

  DoLoginMember(this.userId, this.password);
}
