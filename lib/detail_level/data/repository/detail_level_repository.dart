import '../datasource/detail_level_local_datasource.dart';
import '../datasource/detail_level_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class DetailLevelRepositoryImpl implements DetailLevelRepository {
DetailLevelLocalDataSource detailLevelLocalDataSource;
DetailLevelRemoteDataSource detailLevelRemoteDataSource;
DetailLevelRepositoryImpl(this.detailLevelLocalDataSource, this.detailLevelRemoteDataSource);
}