part of 'fetch_all_pricing_plan_bloc.dart';

@immutable
class FetchAllPricingPlanState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final bool reachMax;
  final int currentPage;
  final List<PricingPlanEntity> datas;

  const FetchAllPricingPlanState(
      {this.datas = const [],
      this.isLoading = false,
      this.isError = false,
      this.reachMax = false,
      this.errorMessage = "",
      this.currentPage = 1});

  FetchAllPricingPlanState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? reachMax,
    int? currentPage,
    List<PricingPlanEntity>? datas,
  }) =>
      FetchAllPricingPlanState(
          isLoading: isLoading ?? this.isLoading,
          isError: isError ?? this.isError,
          errorMessage: errorMessage ?? this.errorMessage,
          reachMax: reachMax ?? this.reachMax,
          currentPage: currentPage ?? this.currentPage,
          datas: datas ?? this.datas);
}
