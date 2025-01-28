import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class CheckBookingSlotLeftUsecase {
  HomepageRepository homepageRepository;
  CheckBookingSlotLeftUsecase(this.homepageRepository);
  Future<Either<Failure, int>> execute() {
    return homepageRepository.checkBookingSlotLeft();
  }
}
