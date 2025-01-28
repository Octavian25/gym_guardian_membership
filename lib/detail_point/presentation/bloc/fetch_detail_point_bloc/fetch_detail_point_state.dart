part of 'fetch_detail_point_bloc.dart';

@immutable
class FetchDetailPointState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final bool reachMax;
  final int currentPage;
  final List<DatumPointHistoryEntity> datas;
  final List<DatumPointHistoryEntity> paged;

  const FetchDetailPointState(
      {this.datas = const [],
      this.paged = const [],
      this.isLoading = false,
      this.isError = false,
      this.reachMax = false,
      this.errorMessage = "",
      this.currentPage = 1});

  FetchDetailPointState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? reachMax,
    int? currentPage,
    List<DatumPointHistoryEntity>? datas,
    List<DatumPointHistoryEntity>? paged,
  }) =>
      FetchDetailPointState(
          isLoading: isLoading ?? this.isLoading,
          isError: isError ?? this.isError,
          errorMessage: errorMessage ?? this.errorMessage,
          reachMax: reachMax ?? this.reachMax,
          currentPage: currentPage ?? this.currentPage,
          datas: datas ?? this.datas,
          paged: paged ?? this.paged);
}
