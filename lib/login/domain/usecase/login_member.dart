import 'package:gym_guardian_membership/login/domain/entities/login_response_entity.dart';
import 'package:gym_guardian_membership/login/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class LoginMemberUsecase {
  LoginRepository loginRepository;
  LoginMemberUsecase(this.loginRepository);
  Future<Either<Failure, LoginResponseEntity>> execute(String userId, String password) {
    return loginRepository.loginMember(userId, password);
  }
}
