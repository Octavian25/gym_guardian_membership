part of 'fetch_activity_member_bloc.dart';

abstract class FetchActivityMemberEvent {}

class DoFetchActivityMember extends FetchActivityMemberEvent {
  final int? page;
  final int? limit;
  final String memberCode;

  DoFetchActivityMember(this.memberCode, this.page, this.limit);
}
