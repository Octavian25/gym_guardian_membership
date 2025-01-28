import 'package:gym_guardian_membership/register/domain/entities/register_request_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RegisterRepository {
  Future<Either<Failure, String>> registerMember(RegisterRequestEntity registerRequestEntity);
}
