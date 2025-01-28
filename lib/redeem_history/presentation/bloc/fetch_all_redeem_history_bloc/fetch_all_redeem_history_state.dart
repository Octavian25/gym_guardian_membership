part of 'fetch_all_redeem_history_bloc.dart';

@immutable
class FetchAllRedeemHistoryState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final bool reachMax;
  final int currentPage;
  final List<DatumRedeemHistoryEntity> datas;
  final List<DatumRedeemHistoryEntity> paginated;

  const FetchAllRedeemHistoryState(
      {this.datas = const [],
      this.paginated = const [],
      this.isLoading = false,
      this.isError = false,
      this.reachMax = false,
      this.errorMessage = "",
      this.currentPage = 1});

  FetchAllRedeemHistoryState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? reachMax,
    int? currentPage,
    List<DatumRedeemHistoryEntity>? datas,
    List<DatumRedeemHistoryEntity>? paginated,
  }) =>
      FetchAllRedeemHistoryState(
          isLoading: isLoading ?? this.isLoading,
          isError: isError ?? this.isError,
          errorMessage: errorMessage ?? this.errorMessage,
          reachMax: reachMax ?? this.reachMax,
          currentPage: currentPage ?? this.currentPage,
          datas: datas ?? this.datas,
          paginated: paginated ?? this.paginated);
}
