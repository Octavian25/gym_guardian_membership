part of 'fetch_all_redeem_history_bloc.dart';

abstract class FetchAllRedeemHistoryEvent {}

class DoFetchAllRedeemHistory extends FetchAllRedeemHistoryEvent {
  String memberCode;
  int? page;
  int? limit;
  DoFetchAllRedeemHistory(this.memberCode, this.page, this.limit);
}
