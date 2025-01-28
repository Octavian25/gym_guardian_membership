
import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:os_basecode/os_basecode.dart';


import '../datasource/detail_point_local_datasource.dart';
import '../datasource/detail_point_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class DetailPointRepositoryImpl implements DetailPointRepository {
  DetailPointLocalDataSource detailPointLocalDataSource;
  DetailPointRemoteDataSource detailPointRemoteDataSource;
  DetailPointRepositoryImpl(this.detailPointLocalDataSource, this.detailPointRemoteDataSource);

  @override
  Future<Either<Failure, PointHistoryEntity>> fetchPointHistoryByMemberCode(
      String memberCode, int? page, int? limit) async {
    try {
      var response =
          await detailPointRemoteDataSource.fetchPointHistoryByMemberCode(memberCode, page, limit);
      return Right(response.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFFPHBMC] We got some problem with our service, please try again'));
    }
  }
}
