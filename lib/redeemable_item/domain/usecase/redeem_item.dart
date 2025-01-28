import 'package:gym_guardian_membership/redeemable_item/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class RedeemItemUsecase {
  RedeemableItemRepository redeemableItemRepository;
  RedeemItemUsecase(this.redeemableItemRepository);
  Future<Either<Failure, String>> execute(String memberCode, String itemId) {
    return redeemableItemRepository.redeemItem(memberCode, itemId);
  }
}
