import 'package:gym_guardian_membership/login/data/models/login_response_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> loginMember(String userId, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  Dio dio;
  LoginRemoteDataSourceImpl(this.dio);
  @override
  Future<LoginResponseModel> loginMember(String userId, String password) async {
    try {
      var response = await dio.post(loginAPI, data: {"user_id": userId, "password": password});
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDELM] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCELM] We got some problems with our service, Try again later');
    }
  }
}
