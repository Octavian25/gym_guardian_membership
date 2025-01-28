import 'package:gym_guardian_membership/pricing_plan/domain/entities/pricing_plan_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/pricing_plan_local_datasource.dart';
import '../datasource/pricing_plan_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class PricingPlanRepositoryImpl implements PricingPlanRepository {
  PricingPlanLocalDataSource pricingPlanLocalDataSource;
  PricingPlanRemoteDataSource pricingPlanRemoteDataSource;
  PricingPlanRepositoryImpl(this.pricingPlanLocalDataSource, this.pricingPlanRemoteDataSource);

  @override
  Future<Either<Failure, List<PricingPlanEntity>>> fetchAllPricingPlan() async {
    try {
      var response = await pricingPlanRemoteDataSource.fetchAllPricingPlan();
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFAPP] We got some problem with our service, please try again'));
    }
  }
}
