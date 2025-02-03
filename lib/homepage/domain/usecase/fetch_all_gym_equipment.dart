import 'package:gym_guardian_membership/homepage/domain/entities/gym_equipment_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchAllGymEquipmentUsecase {
  HomepageRepository homepageRepository;
  FetchAllGymEquipmentUsecase(this.homepageRepository);
  Future<Either<Failure, List<GymEquipmentEntity>>> execute(String? category) {
    return homepageRepository.fetchAllGymEquipment(category);
  }
}
