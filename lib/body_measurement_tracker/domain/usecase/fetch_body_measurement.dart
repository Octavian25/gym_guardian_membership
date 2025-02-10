import 'package:gym_guardian_membership/body_measurement_tracker/domain/repository/repository.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchBodyMeasurementUsecase {
  BodyMeasurementTrackerRepository bodyMeasurementTrackerRepository;
  FetchBodyMeasurementUsecase(this.bodyMeasurementTrackerRepository);
  Future<Either<Failure, List<BodyMeasurementEntity>>> execute(String memberCode) {
    return bodyMeasurementTrackerRepository.fetchBodyMeasurement(memberCode);
  }
}
