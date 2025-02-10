import 'package:gym_guardian_membership/splashscreen/domain/entities/system_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/splashscreen_local_datasource.dart';
import '../datasource/splashscreen_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class SplashscreenRepositoryImpl implements SplashscreenRepository {
  SplashscreenLocalDataSource splashscreenLocalDataSource;
  SplashscreenRemoteDataSource splashscreenRemoteDataSource;
  SharedPreferences pref;
  SplashscreenRepositoryImpl(
      this.splashscreenLocalDataSource, this.splashscreenRemoteDataSource, this.pref);

  @override
  Future<Either<Failure, SystemEntity>> getSystemData() async {
    try {
      var response = await splashscreenRemoteDataSource.getSystemData();
      await pref.setDouble("storeLatitude", response.locationLatitude);
      await pref.setDouble("storeLongitude", response.locationLongitude);
      await pref.setString("storeName", response.locationName);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFGSD] We got some problem with our service, please try again'));
    }
  }
}
