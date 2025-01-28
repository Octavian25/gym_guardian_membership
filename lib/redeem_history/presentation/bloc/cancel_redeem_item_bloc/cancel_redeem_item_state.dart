part of 'cancel_redeem_item_bloc.dart';

@immutable
sealed class CancelRedeemItemState {}

final class CancelRedeemItemInitial extends CancelRedeemItemState {}

class CancelRedeemItemLoading extends CancelRedeemItemState {}

class CancelRedeemItemSuccess extends CancelRedeemItemState {
  final String datas;
  CancelRedeemItemSuccess(this.datas);
}

class CancelRedeemItemFailure extends CancelRedeemItemState {
  final String message;
  CancelRedeemItemFailure(this.message);
}
