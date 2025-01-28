import 'package:gym_guardian_membership/pricing_plan/domain/entities/pricing_plan_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class PricingPlanRepository {
  Future<Either<Failure, List<PricingPlanEntity>>> fetchAllPricingPlan();
}
