part of 'detail_member_bloc.dart';

@immutable
sealed class DetailMemberState {}

final class DetailMemberInitial extends DetailMemberState {}

class DetailMemberLoading extends DetailMemberState {}

class DetailMemberSuccess extends DetailMemberState {
  final MemberEntity datas;
  DetailMemberSuccess(this.datas);
}

class DetailMemberFailure extends DetailMemberState {
  final String message;
  DetailMemberFailure(this.message);
}
