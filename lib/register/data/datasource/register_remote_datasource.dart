import 'package:gym_guardian_membership/register/data/models/register_request_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RegisterRemoteDataSource {
  Future<String> registerMember(RegisterRequestModel registerRequestModel);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  Dio dio;
  RegisterRemoteDataSourceImpl(this.dio);
  @override
  Future<String> registerMember(RegisterRequestModel registerRequestModel) async {
    try {
      await dio.post(memberAPI, data: registerRequestModel.toJson());
      return "Your data has been registered, you can login with your email address and password";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDERM] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCERM] We got some problems with our service, Try again later');
    }
  }
}
