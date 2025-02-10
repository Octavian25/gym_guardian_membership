import 'package:gym_guardian_membership/splashscreen/domain/entities/system_entity.dart';
import 'package:gym_guardian_membership/splashscreen/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class GetSystemDataUsecase {
  SplashscreenRepository splashscreenRepository;
  GetSystemDataUsecase(this.splashscreenRepository);
  Future<Either<Failure, SystemEntity>> execute() {
    return splashscreenRepository.getSystemData();
  }
}
