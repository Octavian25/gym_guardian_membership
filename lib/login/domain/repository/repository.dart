import 'package:gym_guardian_membership/login/domain/entities/login_response_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponseEntity>> loginMember(String userId, String password);
}
