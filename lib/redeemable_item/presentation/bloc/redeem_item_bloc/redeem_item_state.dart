part of 'redeem_item_bloc.dart';

@immutable
sealed class RedeemItemState {}

final class RedeemItemInitial extends RedeemItemState {}

class RedeemItemLoading extends RedeemItemState {}

class RedeemItemSuccess extends RedeemItemState {
  final String datas;
  RedeemItemSuccess(this.datas);
}

class RedeemItemFailure extends RedeemItemState {
  final String message;
  RedeemItemFailure(this.message);
}
