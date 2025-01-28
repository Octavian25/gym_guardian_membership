import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class DetailPointRepository {
  Future<Either<Failure, PointHistoryEntity>> fetchPointHistoryByMemberCode(
      String memberCode, int? page, int? limit);
}
