part of 'fetch_all_redeemable_item_bloc.dart';

@immutable
class FetchAllRedeemableItemState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final bool reachMax;
  final int currentPage;
  final List<DatumRedeemableItemEntity> datas;
  final List<DatumRedeemableItemEntity> paginated;

  const FetchAllRedeemableItemState(
      {this.datas = const [],
      this.paginated = const [],
      this.isLoading = false,
      this.isError = false,
      this.reachMax = false,
      this.errorMessage = "",
      this.currentPage = 1});

  FetchAllRedeemableItemState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? reachMax,
    int? currentPage,
    List<DatumRedeemableItemEntity>? datas,
    List<DatumRedeemableItemEntity>? paginated,
  }) =>
      FetchAllRedeemableItemState(
          isLoading: isLoading ?? this.isLoading,
          isError: isError ?? this.isError,
          errorMessage: errorMessage ?? this.errorMessage,
          reachMax: reachMax ?? this.reachMax,
          currentPage: currentPage ?? this.currentPage,
          datas: datas ?? this.datas,
          paginated: paginated ?? this.paginated);
}
