import '../datasource/splashscreen_local_datasource.dart';
import '../datasource/splashscreen_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class SplashscreenRepositoryImpl implements SplashscreenRepository {
SplashscreenLocalDataSource splashscreenLocalDataSource;
SplashscreenRemoteDataSource splashscreenRemoteDataSource;
SplashscreenRepositoryImpl(this.splashscreenLocalDataSource, this.splashscreenRemoteDataSource);
}