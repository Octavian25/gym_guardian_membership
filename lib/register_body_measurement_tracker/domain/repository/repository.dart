import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RegisterBodyMeasurementTrackerRepository {
  Future<Either<Failure, String>> registerBodyMeasurement(
      BodyMeasurementEntity bodyMeasurementEntity);
}
