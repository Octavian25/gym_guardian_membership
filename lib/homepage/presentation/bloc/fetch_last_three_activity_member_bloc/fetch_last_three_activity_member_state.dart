part of 'fetch_last_three_activity_member_bloc.dart';

@immutable
sealed class FetchLastThreeActivityMemberState {}

final class FetchLastThreeActivityMemberInitial extends FetchLastThreeActivityMemberState {}

class FetchLastThreeActivityMemberLoading extends FetchLastThreeActivityMemberState {}

class FetchLastThreeActivityMemberSuccess extends FetchLastThreeActivityMemberState {
  final List<DatumActivityMemberEntity> datas;
  FetchLastThreeActivityMemberSuccess(this.datas);
}

class FetchLastThreeActivityMemberFailure extends FetchLastThreeActivityMemberState {
  final String message;
  FetchLastThreeActivityMemberFailure(this.message);
}
