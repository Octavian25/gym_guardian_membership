import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/booking_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/gym_equipment_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/register_attendance_reponse_entity.dart';
import 'package:gym_guardian_membership/register/domain/entities/member_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class HomepageRepository {
  Future<Either<Failure, MemberEntity>> fetchDetailMemberByEmail(String memberEmail);
  Future<Either<Failure, List<GymEquipmentEntity>>> fetchAllGymEquipment(String? category);
  Future<Either<Failure, ActivityMemberEntity>> fetchActivityMemberByCode(
      String memberCode, int? page, int? limit);
  Future<Either<Failure, int>> checkBookingSlotLeft();
  Future<Either<Failure, String>> requestBooking(String memberCode, String bookingDate);
  Future<Either<Failure, String>> cancelBooking(String memberCode);
  Future<Either<Failure, RegisterAttendanceResponseEntity>> registerAttendance(String memberCode);
  Future<Either<Failure, String>> logoutMember(String userId, String refreshToken);
  Future<Either<Failure, BookingEntity>> fetchAllBooking(String memberCode, int? page, int? limit);
}
