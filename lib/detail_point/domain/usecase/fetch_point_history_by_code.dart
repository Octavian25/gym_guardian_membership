import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:gym_guardian_membership/detail_point/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchPointHistoyByCodeUsecase {
  DetailPointRepository detailPointRepository;
  FetchPointHistoyByCodeUsecase(this.detailPointRepository);
  Future<Either<Failure, PointHistoryEntity>> execute(String memberCode, int? page, int? limit) {
    return detailPointRepository.fetchPointHistoryByMemberCode(memberCode, page, limit);
  }
}
