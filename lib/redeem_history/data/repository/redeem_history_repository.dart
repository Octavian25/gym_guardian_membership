import 'package:dartz/dartz.dart';

import 'package:gym_guardian_membership/redeem_history/domain/entities/redeem_history_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import 'package:os_basecode/utilities/failure.dart';

import '../datasource/redeem_history_local_datasource.dart';
import '../datasource/redeem_history_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class RedeemHistoryRepositoryImpl implements RedeemHistoryRepository {
  RedeemHistoryLocalDataSource redeemHistoryLocalDataSource;
  RedeemHistoryRemoteDataSource redeemHistoryRemoteDataSource;
  RedeemHistoryRepositoryImpl(
      this.redeemHistoryLocalDataSource, this.redeemHistoryRemoteDataSource);

  @override
  Future<Either<Failure, RedeemHistoryEntity>> fetchAllRedeemHistory(
      String memberCode, int? page, int? limit) async {
    try {
      var response =
          await redeemHistoryRemoteDataSource.fetchAllRedeemHistory(memberCode, page, limit);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFARH] We got some problem with our service, please try again'));
    }
  }

  @override
  Future<Either<Failure, String>> cancelRedeemItem(String id) async {
    try {
      var response = await redeemHistoryRemoteDataSource.cancelRedeemItem(id);
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFCRI] We got some problem with our service, please try again'));
    }
  }
}
