import 'package:gym_guardian_membership/redeemable_item/data/datasource/reedemable_item_local_datasource.dart';
import 'package:gym_guardian_membership/redeemable_item/data/datasource/reedemable_item_remote_datasource.dart';

import 'package:gym_guardian_membership/redeemable_item/domain/entities/redeemable_item_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../../domain/repository/repository.dart';

class RedeemableItemRepositoryImpl implements RedeemableItemRepository {
  RedeemableItemLocalDataSource redeemableItemLocalDataSource;
  RedeemableItemRemoteDataSource redeemableItemRemoteDataSource;
  RedeemableItemRepositoryImpl(
      this.redeemableItemLocalDataSource, this.redeemableItemRemoteDataSource);

  @override
  Future<Either<Failure, RedeemableItemEntity>> fetchAllRedeemableItem(
      int? page, int? limit) async {
    try {
      var response = await redeemableItemRemoteDataSource.fetchAllRedeemableItems(page, limit);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFARI] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, String>> redeemItem(String memberCode, String itemId) async {
    try {
      var response = await redeemableItemRemoteDataSource.redeemItems(memberCode, itemId);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFRI] We got some problem with our service, please try again'));
    }
  }
}
