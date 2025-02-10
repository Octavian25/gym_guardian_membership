import 'package:gym_guardian_membership/gym_schedule/data/models/calendar_event_data.dart';
import 'package:os_basecode/os_basecode.dart';


import '../datasource/gym_schedule_local_datasource.dart';
import '../datasource/gym_schedule_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class GymScheduleRepositoryImpl implements GymScheduleRepository {
  GymScheduleLocalDataSource gymScheduleLocalDataSource;
  GymScheduleRemoteDataSource gymScheduleRemoteDataSource;
  GymScheduleRepositoryImpl(this.gymScheduleLocalDataSource, this.gymScheduleRemoteDataSource);

  @override
  Future<Either<Failure, List<CalendarEventData>>> fetchEventSchedule() async {
    try {
      var response = await gymScheduleRemoteDataSource.fetchEventSchedule();
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFES] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, String>> cancelReservationEventSchedule(
      String memberCode, String event) async {
    try {
      var response =
          await gymScheduleRemoteDataSource.cancelReservationEventSchedule(event, memberCode);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFCRES] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, String>> reservationEventSchedule(String memberCode, String event) async {
    try {
      var response = await gymScheduleRemoteDataSource.reservationEventSchedule(event, memberCode);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFRES] We got some problem with our service, please try again'));
    }
  }
}
