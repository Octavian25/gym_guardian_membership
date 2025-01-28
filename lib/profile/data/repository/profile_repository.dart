import 'package:gym_guardian_membership/profile/domain/entities/update_profile_entity.dart';
import 'package:os_basecode/os_basecode.dart';

import '../datasource/profile_local_datasource.dart';
import '../datasource/profile_remote_datasource.dart';
import '../../domain/repository/repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileLocalDataSource profileLocalDataSource;
  ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl(this.profileLocalDataSource, this.profileRemoteDataSource);

  @override
  Future<Either<Failure, String>> updateProfile(UpdateProfileEntity updateProfileEntity) async {
    try {
      var response = await profileRemoteDataSource.updateProfile(updateProfileEntity.toModel());
      return Right(response);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on CommonException catch (e) {
      return Left(CommonFailure(e.message));
    } catch (e) {
      return const Left(
          CommonFailure('[RPCFUP] We got some problem with our service, please try again'));
    }
  }
}
