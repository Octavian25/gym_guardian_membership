import 'package:gym_guardian_membership/homepage/domain/entities/register_attendance_reponse_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class RegisterAttendanceUsecase {
  HomepageRepository homepageRepository;
  RegisterAttendanceUsecase(this.homepageRepository);
  Future<Either<Failure, RegisterAttendanceResponseEntity>> execute(
      String memberCode, String eligibleForPoints) {
    return homepageRepository.registerAttendance(memberCode, eligibleForPoints);
  }
}
