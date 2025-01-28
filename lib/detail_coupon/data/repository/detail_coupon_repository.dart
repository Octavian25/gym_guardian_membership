import '../datasource/detail_coupon_local_datasource.dart';
import '../datasource/detail_coupon_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class DetailCouponRepositoryImpl implements DetailCouponRepository {
DetailCouponLocalDataSource detailCouponLocalDataSource;
DetailCouponRemoteDataSource detailCouponRemoteDataSource;
DetailCouponRepositoryImpl(this.detailCouponLocalDataSource, this.detailCouponRemoteDataSource);
}