import 'package:gym_guardian_membership/splashscreen/data/models/system_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class SplashscreenRemoteDataSource {
  Future<SystemModel> getSystemData();
}

class SplashscreenRemoteDataSourceImpl implements SplashscreenRemoteDataSource {
  Dio dio;
  SplashscreenRemoteDataSourceImpl(this.dio);

  @override
  Future<SystemModel> getSystemData() async {
    try {
      var result = await dio.get(systemsAPI);
      if ((result.data as List<dynamic>).isEmpty) {
        throw Exception('System Data Not Setted');
      }
      return SystemModel.fromJson(result.data[0]);
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDEGSD] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEGSD] We got some problems with our service, Try again later');
    }
  }
}
