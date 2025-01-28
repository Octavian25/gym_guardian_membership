import 'package:gym_guardian_membership/redeem_history/data/models/redeem_history_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RedeemHistoryRemoteDataSource {
  Future<RedeemHistoryModel> fetchAllRedeemHistory(String memberCode, int? page, int? limit);
  Future<String> cancelRedeemItem(String id);
}

class RedeemHistoryRemoteDataSourceImpl implements RedeemHistoryRemoteDataSource {
  Dio dio;

  RedeemHistoryRemoteDataSourceImpl(this.dio);
  @override
  Future<RedeemHistoryModel> fetchAllRedeemHistory(String memberCode, int? page, int? limit) async {
    try {
      var result = await dio.get("$redeemHistoryByMemberAPI/$memberCode", queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        'sortType': "desc"
      });
      return RedeemHistoryModel.fromJson(result.data);
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDEFARH] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFARH] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<String> cancelRedeemItem(String id) async {
    try {
      await dio.delete("$redeemHistoryAPI/$id");
      return "You have successfully cancel the redeem item request";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDECRI] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCECRI] We got some problems with our service, Try again later');
    }
  }
}
