import 'package:gym_guardian_membership/profile/domain/entities/update_profile_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> updateProfile(UpdateProfileEntity updateProfileEntity);
}
