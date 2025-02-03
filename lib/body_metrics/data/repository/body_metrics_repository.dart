import '../datasource/body_metrics_local_datasource.dart';
import '../datasource/body_metrics_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class BodyMetricsRepositoryImpl implements BodyMetricsRepository {
BodyMetricsLocalDataSource bodyMetricsLocalDataSource;
BodyMetricsRemoteDataSource bodyMetricsRemoteDataSource;
BodyMetricsRepositoryImpl(this.bodyMetricsLocalDataSource, this.bodyMetricsRemoteDataSource);
}