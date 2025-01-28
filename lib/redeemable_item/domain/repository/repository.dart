import 'package:gym_guardian_membership/redeemable_item/domain/entities/redeemable_item_entity.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RedeemableItemRepository {
  Future<Either<Failure, RedeemableItemEntity>> fetchAllRedeemableItem(int? page, int? limit);
  Future<Either<Failure, String>> redeemItem(String memberCode, String itemId);
}
