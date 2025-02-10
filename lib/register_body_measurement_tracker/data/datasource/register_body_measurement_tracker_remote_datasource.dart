import 'package:gym_guardian_membership/register_body_measurement_tracker/data/models/body_measurement_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RegisterBodyMeasurementTrackerRemoteDataSource {
  Future<String> registerBodyMeasurement(BodyMeasurementModel bodyMeasurementModel);
}

class RegisterBodyMeasurementTrackerRemoteDataSourceImpl
    implements RegisterBodyMeasurementTrackerRemoteDataSource {
  Dio dio;

  RegisterBodyMeasurementTrackerRemoteDataSourceImpl(this.dio);
  @override
  Future<String> registerBodyMeasurement(BodyMeasurementModel bodyMeasurementModel) async {
    try {
      await dio.post(bodyMeasurementAPI, data: bodyMeasurementModel.toJson());
      return "Register Body Measurement Success";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDERBM] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCERBM] We got some problems with our service, Try again later');
    }
  }
}
