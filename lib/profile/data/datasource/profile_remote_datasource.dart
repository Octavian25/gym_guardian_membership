import 'package:gym_guardian_membership/profile/data/models/update_profile_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class ProfileRemoteDataSource {
  Future<String> updateProfile(UpdateProfileModel updateProfileModel);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);
  @override
  Future<String> updateProfile(UpdateProfileModel updateProfileModel) async {
    try {
      await dio.put(updateProfileAPI, data: {
        "member_name": updateProfileModel.memberName,
        "member_email": updateProfileModel.memberEmail,
        "member_code": updateProfileModel.id
      });
      return "Update profile successfully, please re-login to see the changes";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDEUP] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEUP] We got some problems with our service, Try again later');
    }
  }
}
