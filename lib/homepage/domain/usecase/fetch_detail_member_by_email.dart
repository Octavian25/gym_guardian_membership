import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:gym_guardian_membership/register/domain/entities/member_entity.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchDetailMemberByEmailUsecase {
  HomepageRepository homepageRepository;
  FetchDetailMemberByEmailUsecase(this.homepageRepository);
  Future<Either<Failure, MemberEntity>> execute(String memberEmail) {
    return homepageRepository.fetchDetailMemberByEmail(memberEmail);
  }
}
