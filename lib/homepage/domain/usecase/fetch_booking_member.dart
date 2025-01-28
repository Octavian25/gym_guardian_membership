import 'package:gym_guardian_membership/homepage/domain/entities/booking_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchBookingUsecase {
  HomepageRepository homepageRepository;
  FetchBookingUsecase(this.homepageRepository);
  Future<Either<Failure, BookingEntity>> execute(String memberCode, int? page, int? limit) {
    return homepageRepository.fetchAllBooking(memberCode, page, limit);
  }
}
