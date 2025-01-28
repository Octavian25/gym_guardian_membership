import 'package:gym_guardian_membership/pricing_plan/domain/entities/pricing_plan_entity.dart';
import 'package:gym_guardian_membership/pricing_plan/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchAllPricingPlanUsecase {
  PricingPlanRepository pricingPlanRepository;
  FetchAllPricingPlanUsecase(this.pricingPlanRepository);
  Future<Either<Failure, List<PricingPlanEntity>>> execute() {
    return pricingPlanRepository.fetchAllPricingPlan();
  }
}
