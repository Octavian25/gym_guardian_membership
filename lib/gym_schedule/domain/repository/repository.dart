import 'package:gym_guardian_membership/gym_schedule/data/models/calendar_event_data.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class GymScheduleRepository {
  Future<Either<Failure, List<CalendarEventData>>> fetchEventSchedule();
  Future<Either<Failure, String>> reservationEventSchedule(String memberCode, String event);
  Future<Either<Failure, String>> cancelReservationEventSchedule(String memberCode, String event);
}
