import 'package:gym_guardian_membership/redeemable_item/domain/entities/redeemable_item_entity.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/repository/repository.dart';
import 'package:os_basecode/os_basecode.dart';

class FetchAllRedeemableItemUsecase {
  RedeemableItemRepository redeemableItemRepository;
  FetchAllRedeemableItemUsecase(this.redeemableItemRepository);
  Future<Either<Failure, RedeemableItemEntity>> execute(int? page, int? limit) {
    return redeemableItemRepository.fetchAllRedeemableItem(page, limit);
  }
}
