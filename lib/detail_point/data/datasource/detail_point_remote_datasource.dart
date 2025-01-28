import 'package:gym_guardian_membership/detail_point/data/models/point_history_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class DetailPointRemoteDataSource {
  Future<PointHistoryModel> fetchPointHistoryByMemberCode(String memberCode, int? page, int? limit);
}

class DetailPointRemoteDataSourceImpl implements DetailPointRemoteDataSource {
  Dio dio;
  DetailPointRemoteDataSourceImpl(this.dio);
  @override
  Future<PointHistoryModel> fetchPointHistoryByMemberCode(
      String memberCode, int? page, int? limit) async {
    try {
      var queryParams = {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        "sortType": 'dsc'
      };
      var response = await dio.get("$pointsByCodeAPI$memberCode", queryParameters: queryParams);
      return PointHistoryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDEFPHBMC] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFPHBMC] We got some problems with our service, Try again later');
    }
  }
}
