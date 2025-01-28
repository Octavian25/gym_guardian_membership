import 'package:gym_guardian_membership/redeem_history/domain/entities/redeem_history_entity.dart';
import 'package:gym_guardian_membership/redeem_history/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchAllRedeemHistoryUsecase {
  RedeemHistoryRepository redeemHistoryRepository;
  FetchAllRedeemHistoryUsecase(this.redeemHistoryRepository);
  Future<Either<Failure, RedeemHistoryEntity>> execute(String memberCode, int? page, int? limit) {
    return redeemHistoryRepository.fetchAllRedeemHistory(memberCode, page, limit);
  }
}
