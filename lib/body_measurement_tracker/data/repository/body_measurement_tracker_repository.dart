import '../datasource/body_measurement_tracker_local_datasource.dart';
import '../datasource/body_measurement_tracker_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class BodyMeasurementTrackerRepositoryImpl implements BodyMeasurementTrackerRepository {
BodyMeasurementTrackerLocalDataSource bodyMeasurementTrackerLocalDataSource;
BodyMeasurementTrackerRemoteDataSource bodyMeasurementTrackerRemoteDataSource;
BodyMeasurementTrackerRepositoryImpl(this.bodyMeasurementTrackerLocalDataSource, this.bodyMeasurementTrackerRemoteDataSource);
}