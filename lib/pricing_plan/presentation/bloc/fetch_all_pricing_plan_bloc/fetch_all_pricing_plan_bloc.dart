import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/domain/entities/pricing_plan_entity.dart';
import 'package:gym_guardian_membership/pricing_plan/domain/usecase/fetch_all_pricing_plan.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';

part 'fetch_all_pricing_plan_event.dart';
part 'fetch_all_pricing_plan_state.dart';

class FetchAllPricingPlanBloc extends Bloc<FetchAllPricingPlanEvent, FetchAllPricingPlanState> {
  FetchAllPricingPlanUsecase fetchAllPricingPlanUsecase;
  FetchAllPricingPlanBloc(this.fetchAllPricingPlanUsecase) : super(FetchAllPricingPlanState()) {
    on<DoFetchAllPricingPlan>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      GlobalLoader.show();
      var response = await fetchAllPricingPlanUsecase.execute();
      response.fold((l) {
        emit(state.copyWith(isLoading: false, isError: true, errorMessage: l.message));
      }, (r) {
        emit(state.copyWith(isLoading: false, isError: false, errorMessage: "", datas: r));
      });
      GlobalLoader.hide();
    });
  }
}
