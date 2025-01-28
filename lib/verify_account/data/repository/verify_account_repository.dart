import '../datasource/verify_account_local_datasource.dart';
import '../datasource/verify_account_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class VerifyAccountRepositoryImpl implements VerifyAccountRepository {
VerifyAccountLocalDataSource verifyAccountLocalDataSource;
VerifyAccountRemoteDataSource verifyAccountRemoteDataSource;
VerifyAccountRepositoryImpl(this.verifyAccountLocalDataSource, this.verifyAccountRemoteDataSource);
}