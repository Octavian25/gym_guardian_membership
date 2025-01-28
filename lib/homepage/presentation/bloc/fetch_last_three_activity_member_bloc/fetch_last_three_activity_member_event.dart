part of 'fetch_last_three_activity_member_bloc.dart';

abstract class FetchLastThreeActivityMemberEvent {}

class DoFetchLastThreeActivityMember extends FetchLastThreeActivityMemberEvent {
  final int? page;
  final int? limit;
  final String memberCode;

  DoFetchLastThreeActivityMember(this.memberCode, this.page, this.limit);
}
