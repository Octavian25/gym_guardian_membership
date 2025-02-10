import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class RegisterBodyMeasurementTrackerUsecase {
  RegisterBodyMeasurementTrackerRepository registerBodyMeasurementTrackerRepository;
  RegisterBodyMeasurementTrackerUsecase(this.registerBodyMeasurementTrackerRepository);
  Future<Either<Failure, String>> execute(BodyMeasurementEntity bodyMeasurementEntity) {
    return registerBodyMeasurementTrackerRepository.registerBodyMeasurement(bodyMeasurementEntity);
  }
}
