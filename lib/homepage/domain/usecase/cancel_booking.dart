import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class CancelBookingUsecase {
  HomepageRepository homepageRepository;
  CancelBookingUsecase(this.homepageRepository);
  Future<Either<Failure, String>> execute(String id) {
    return homepageRepository.cancelBooking(id);
  }
}
