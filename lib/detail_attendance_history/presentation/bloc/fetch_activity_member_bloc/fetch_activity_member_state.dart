part of 'fetch_activity_member_bloc.dart';

@immutable
class FetchActivityMemberState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final bool reachMax;
  final int currentPage;
  final List<DatumActivityMemberEntity> datas;
  final List<DatumActivityMemberEntity> paged;

  const FetchActivityMemberState(
      {this.datas = const [],
      this.paged = const [],
      this.isLoading = false,
      this.isError = false,
      this.reachMax = false,
      this.errorMessage = "",
      this.currentPage = 1});

  FetchActivityMemberState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? reachMax,
    int? currentPage,
    List<DatumActivityMemberEntity>? datas,
    List<DatumActivityMemberEntity>? paged,
  }) =>
      FetchActivityMemberState(
          isLoading: isLoading ?? this.isLoading,
          isError: isError ?? this.isError,
          errorMessage: errorMessage ?? this.errorMessage,
          reachMax: reachMax ?? this.reachMax,
          currentPage: currentPage ?? this.currentPage,
          datas: datas ?? this.datas,
          paged: paged ?? this.paged);
}
