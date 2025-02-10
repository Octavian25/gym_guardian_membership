import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/booking_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/gym_equipment_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/register_attendance_reponse_entity.dart';
import 'package:gym_guardian_membership/register/domain/entities/member_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/homepage_local_datasource.dart';
import '../datasource/homepage_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class HomepageRepositoryImpl implements HomepageRepository {
  HomepageLocalDataSource homepageLocalDataSource;
  HomepageRemoteDataSource homepageRemoteDataSource;
  HomepageRepositoryImpl(this.homepageLocalDataSource, this.homepageRemoteDataSource);

  @override
  Future<Either<Failure, MemberEntity>> fetchDetailMemberByEmail(String memberEmail) async {
    try {
      var response = await homepageRemoteDataSource.fetchDetailMemberByEmail(memberEmail);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFDMBE] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, ActivityMemberEntity>> fetchActivityMemberByCode(
      String memberCode, int? page, int? limit) async {
    try {
      var response =
          await homepageRemoteDataSource.fetchActivityMemberByCode(memberCode, page, limit);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFAMDC] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, int>> checkBookingSlotLeft() async {
    try {
      var response = await homepageRemoteDataSource.checkBookingSlotLeft();
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFCBSL] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, String>> requestBooking(String memberCode, String bookingDate) async {
    try {
      var response = await homepageRemoteDataSource.requestBooking(memberCode, bookingDate);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFRB] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, BookingEntity>> fetchAllBooking(
      String memberCode, int? page, int? limit) async {
    try {
      var response = await homepageRemoteDataSource.fetchAllBookings(memberCode, page, limit);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFAB] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, String>> cancelBooking(String memberCode) async {
    try {
      var response = await homepageRemoteDataSource.cancelBooking(memberCode);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFDB] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, String>> logoutMember(String userId, String refreshToken) async {
    try {
      var response = await homepageRemoteDataSource.logoutMember(userId, refreshToken);
      var pref = await SharedPreferences.getInstance();
      pref.clear();
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFLM] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, RegisterAttendanceResponseEntity>> registerAttendance(
      String memberCode, String eligibleForPoints) async {
    try {
      var response =
          await homepageRemoteDataSource.registerAttendance(memberCode, eligibleForPoints);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFRA] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, List<GymEquipmentEntity>>> fetchAllGymEquipment(String? category) async {
    try {
      var response = await homepageRemoteDataSource.fetchAllGymEquipment(category);
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFAGE] We got some problem with our service, please try again'));
    }
  }
}
