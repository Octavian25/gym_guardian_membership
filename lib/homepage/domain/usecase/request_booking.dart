import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class RequestBookingUsecase {
  HomepageRepository homepageRepository;
  RequestBookingUsecase(this.homepageRepository);
  Future<Either<Failure, String>> execute(String memberCode, String bookingDate) {
    return homepageRepository.requestBooking(memberCode, bookingDate);
  }
}
