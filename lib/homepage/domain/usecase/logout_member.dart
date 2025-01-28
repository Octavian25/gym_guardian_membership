import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class LogoutMemberUsecase {
  HomepageRepository homepageRepository;
  LogoutMemberUsecase(this.homepageRepository);
  Future<Either<Failure, String>> execute(String userId, String refreshToken) {
    return homepageRepository.logoutMember(userId, refreshToken);
  }
}
