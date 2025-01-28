import '../datasource/forgot_password_local_datasource.dart';
import '../datasource/forgot_password_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
ForgotPasswordLocalDataSource forgotPasswordLocalDataSource;
ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;
ForgotPasswordRepositoryImpl(this.forgotPasswordLocalDataSource, this.forgotPasswordRemoteDataSource);
}