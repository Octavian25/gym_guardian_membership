part of 'fetch_all_redeemable_item_bloc.dart';

abstract class FetchAllRedeemableItemEvent {}

class DoFetchAllRedeemableItem extends FetchAllRedeemableItemEvent {
  final int? page;
  final int? limit;

  DoFetchAllRedeemableItem(this.page, this.limit);
}
