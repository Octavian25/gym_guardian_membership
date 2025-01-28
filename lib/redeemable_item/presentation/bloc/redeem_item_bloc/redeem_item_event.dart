part of 'redeem_item_bloc.dart';

abstract class RedeemItemEvent {}

class DoRedeemItem extends RedeemItemEvent {
  final String memberCode;
  final String itemId;
  DoRedeemItem(this.memberCode, this.itemId);
}
