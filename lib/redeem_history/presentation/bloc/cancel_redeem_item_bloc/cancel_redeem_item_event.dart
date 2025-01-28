part of 'cancel_redeem_item_bloc.dart';

abstract class CancelRedeemItemEvent {}

class DoCancelRedeemItem extends CancelRedeemItemEvent {
  final String id;
  DoCancelRedeemItem(this.id);
}
