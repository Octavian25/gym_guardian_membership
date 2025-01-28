import 'package:gym_guardian_membership/local_storage.dart';
import 'package:gym_guardian_membership/login/domain/entities/login_response_entity.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/login_local_datasource.dart';
import '../datasource/login_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginLocalDataSource loginLocalDataSource;
  LoginRemoteDataSource loginRemoteDataSource;
  SharedPreferences pref;
  LoginRepositoryImpl(this.loginLocalDataSource, this.loginRemoteDataSource, this.pref);

  @override
  Future<Either<Failure, LoginResponseEntity>> loginMember(String userId, String password) async {
    try {
      var response = await loginRemoteDataSource.loginMember(userId, password);
      var clearStatus = await LocalStorage(pref).removeAllItem();
      if (!clearStatus) {
        return const Left(CommonFailure('[RPCFLM] CLEAR TEMP DATA ERROR'));
      }
      await LocalStorage(pref).setItem<String>(userIdKey, userId);
      await LocalStorage(pref).setItem<String>(accessToken, response.accessToken);
      await LocalStorage(pref).setItem<String>(refreshToken, response.refreshToken);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFLM] We got some problem with our service, please try again'));
    }
  }
}
