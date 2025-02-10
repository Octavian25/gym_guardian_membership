import 'package:gym_guardian_membership/gym_schedule/data/models/calendar_event_data.dart';
import 'package:gym_guardian_membership/gym_schedule/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchEventScheduleUsecase {
  GymScheduleRepository gymScheduleRepository;
  FetchEventScheduleUsecase(this.gymScheduleRepository);
  Future<Either<Failure, List<CalendarEventData>>> execute() {
    return gymScheduleRepository.fetchEventSchedule();
  }
}
