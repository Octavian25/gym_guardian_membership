part of 'detail_member_bloc.dart';

@immutable
sealed class DetailMemberState {}

final class DetailMemberInitial extends DetailMemberState {}

class DetailMemberLoading extends DetailMemberState {}

class DetailMemberSuccess extends DetailMemberState {
  final MemberEntity datas;
  final bool initState;
  DetailMemberSuccess(this.datas, this.initState);
}

class DetailMemberFailure extends DetailMemberState {
  final String message;
  DetailMemberFailure(this.message);
}
