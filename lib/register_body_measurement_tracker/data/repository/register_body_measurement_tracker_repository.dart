import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/register_body_measurement_tracker_local_datasource.dart';
import '../datasource/register_body_measurement_tracker_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class RegisterBodyMeasurementTrackerRepositoryImpl
    implements RegisterBodyMeasurementTrackerRepository {
  RegisterBodyMeasurementTrackerLocalDataSource registerBodyMeasurementTrackerLocalDataSource;
  RegisterBodyMeasurementTrackerRemoteDataSource registerBodyMeasurementTrackerRemoteDataSource;
  RegisterBodyMeasurementTrackerRepositoryImpl(this.registerBodyMeasurementTrackerLocalDataSource,
      this.registerBodyMeasurementTrackerRemoteDataSource);

  @override
  Future<Either<Failure, String>> registerBodyMeasurement(
      BodyMeasurementEntity bodyMeasurementEntity) async {
    try {
      var response = await registerBodyMeasurementTrackerRemoteDataSource
          .registerBodyMeasurement(bodyMeasurementEntity.toModel());
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFRBM] We got some problem with our service, please try again'));
    }
  }
}
