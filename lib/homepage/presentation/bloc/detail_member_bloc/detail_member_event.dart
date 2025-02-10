part of 'detail_member_bloc.dart';

abstract class DetailMemberEvent {}

class DoDetailMember extends DetailMemberEvent {
  final bool initState;
  DoDetailMember(this.initState);
}
