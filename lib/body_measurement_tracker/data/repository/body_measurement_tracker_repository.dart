import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/body_measurement_tracker_local_datasource.dart';
import '../datasource/body_measurement_tracker_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class BodyMeasurementTrackerRepositoryImpl implements BodyMeasurementTrackerRepository {
  BodyMeasurementTrackerLocalDataSource bodyMeasurementTrackerLocalDataSource;
  BodyMeasurementTrackerRemoteDataSource bodyMeasurementTrackerRemoteDataSource;
  BodyMeasurementTrackerRepositoryImpl(
      this.bodyMeasurementTrackerLocalDataSource, this.bodyMeasurementTrackerRemoteDataSource);

  @override
  Future<Either<Failure, List<BodyMeasurementEntity>>> fetchBodyMeasurement(
      String memberCode) async {
    try {
      var response = await bodyMeasurementTrackerRemoteDataSource.fetchBodyMeasurements(memberCode);
      return Right(response.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFBM] We got some problem with our service, please try again'));
    }
  }
}
