import 'package:gym_guardian_membership/splashscreen/domain/entities/system_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class SplashscreenRepository {
  Future<Either<Failure, SystemEntity>> getSystemData();
}
