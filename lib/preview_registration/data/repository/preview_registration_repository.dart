import '../datasource/preview_registration_local_datasource.dart';
import '../datasource/preview_registration_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class PreviewRegistrationRepositoryImpl implements PreviewRegistrationRepository {
PreviewRegistrationLocalDataSource previewRegistrationLocalDataSource;
PreviewRegistrationRemoteDataSource previewRegistrationRemoteDataSource;
PreviewRegistrationRepositoryImpl(this.previewRegistrationLocalDataSource, this.previewRegistrationRemoteDataSource);
}