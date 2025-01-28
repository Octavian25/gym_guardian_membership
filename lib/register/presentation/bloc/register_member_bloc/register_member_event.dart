part of 'register_member_bloc.dart';

abstract class RegisterMemberEvent {}

class DoRegisterMember extends RegisterMemberEvent {
  final RegisterRequestEntity registerRequestEntity;
  DoRegisterMember(this.registerRequestEntity);
}
