import 'package:gym_guardian_membership/profile/domain/entities/update_profile_entity.dart';
import 'package:gym_guardian_membership/profile/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class UpdateProfileUsecase {
  ProfileRepository profileRepository;
  UpdateProfileUsecase(this.profileRepository);
  Future<Either<Failure, String>> execute(UpdateProfileEntity updateProfileEntity) {
    return profileRepository.updateProfile(updateProfileEntity);
  }
}
