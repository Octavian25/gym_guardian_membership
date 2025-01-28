import 'package:gym_guardian_membership/redeem_history/domain/entities/redeem_history_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RedeemHistoryRepository {
  Future<Either<Failure, RedeemHistoryEntity>> fetchAllRedeemHistory(
      String memberCode, int? page, int? limit);
  Future<Either<Failure, String>> cancelRedeemItem(String id);
}
