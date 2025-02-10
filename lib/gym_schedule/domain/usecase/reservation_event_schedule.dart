import 'package:gym_guardian_membership/gym_schedule/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class ReservationEventScheduleUsecase {
  GymScheduleRepository gymScheduleRepository;
  ReservationEventScheduleUsecase(this.gymScheduleRepository);
  Future<Either<Failure, String>> execute(String memberCode, String event) {
    return gymScheduleRepository.reservationEventSchedule(memberCode, event);
  }
}
