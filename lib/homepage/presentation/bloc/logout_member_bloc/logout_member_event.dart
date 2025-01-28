part of 'logout_member_bloc.dart';

abstract class LogoutMemberEvent {}

class DoLogoutMember extends LogoutMemberEvent {}

class DoForceLogout extends LogoutMemberEvent {
  final String memberEmail;

  DoForceLogout(this.memberEmail);
}
