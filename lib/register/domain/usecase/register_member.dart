import 'package:gym_guardian_membership/register/domain/entities/register_request_entity.dart';
import 'package:gym_guardian_membership/register/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class RegisterMemberUsecase {
  RegisterRepository registerRepository;
  RegisterMemberUsecase(this.registerRepository);
  Future<Either<Failure, String>> execute(RegisterRequestEntity registerRequestEntity) {
    return registerRepository.registerMember(registerRequestEntity);
  }
}
