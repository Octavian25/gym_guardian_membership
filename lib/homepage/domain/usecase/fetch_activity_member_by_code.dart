import 'package:gym_guardian_membership/homepage/domain/entities/activity_member_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchActivityMemberByCodeUsecase {
  HomepageRepository homepageRepository;
  FetchActivityMemberByCodeUsecase(this.homepageRepository);
  Future<Either<Failure, ActivityMemberEntity>> execute(String memberCode, int? page, int? limit) {
    return homepageRepository.fetchActivityMemberByCode(memberCode, page, limit);
  }
}
