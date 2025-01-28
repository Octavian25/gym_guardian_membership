import 'package:gym_guardian_membership/register/domain/entities/register_request_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/register_local_datasource.dart';
import '../datasource/register_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterLocalDataSource registerLocalDataSource;
  RegisterRemoteDataSource registerRemoteDataSource;
  RegisterRepositoryImpl(this.registerLocalDataSource, this.registerRemoteDataSource);

  @override
  Future<Either<Failure, String>> registerMember(
      RegisterRequestEntity registerRequestEntity) async {
    try {
      var response = await registerRemoteDataSource.registerMember(registerRequestEntity.toModel());
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFRM] We got some problem with our service, please try again'));
    }
  }
}
