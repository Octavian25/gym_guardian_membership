import 'package:gym_guardian_membership/pricing_plan/data/models/pricing_plan_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class PricingPlanRemoteDataSource {
  Future<List<PricingPlanModel>> fetchAllPricingPlan();
}

class PricingPlanRemoteDataSourceImpl implements PricingPlanRemoteDataSource {
  Dio dio;
  PricingPlanRemoteDataSourceImpl(this.dio);
  @override
  Future<List<PricingPlanModel>> fetchAllPricingPlan() async {
    try {
      var result = await dio.get(pricingPlanAPI);
      return pricingPlanModelFromJson(result.data);
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDEFALPP] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFALPP] We got some problems with our service, Try again later');
    }
  }
}
