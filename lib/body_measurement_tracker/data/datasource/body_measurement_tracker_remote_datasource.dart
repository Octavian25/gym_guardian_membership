import 'package:gym_guardian_membership/register_body_measurement_tracker/data/models/body_measurement_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class BodyMeasurementTrackerRemoteDataSource {
  Future<List<BodyMeasurementModel>> fetchBodyMeasurements(String memberCode);
}

class BodyMeasurementTrackerRemoteDataSourceImpl implements BodyMeasurementTrackerRemoteDataSource {
  Dio dio;
  BodyMeasurementTrackerRemoteDataSourceImpl(this.dio);
  @override
  Future<List<BodyMeasurementModel>> fetchBodyMeasurements(String memberCode) async {
    try {
      var result = await dio
          .get(bodyMeasurementAPI, queryParameters: {"member_code": memberCode, "total_data": 7});
      return bodyMeasurementModelFromJson(result.data);
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDEFBM] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFBM] We got some problems with our service, Try again later');
    }
  }
}
