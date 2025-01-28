import 'package:gym_guardian_membership/redeem_history/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class CancelRedeemItemUsecase {
  RedeemHistoryRepository redeemHistoryRepository;
  CancelRedeemItemUsecase(this.redeemHistoryRepository);
  Future<Either<Failure, String>> execute(String id) {
    return redeemHistoryRepository.cancelRedeemItem(id);
  }
}
