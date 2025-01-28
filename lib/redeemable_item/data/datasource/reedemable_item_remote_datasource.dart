import 'package:gym_guardian_membership/redeemable_item/data/models/redeemable_item_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class RedeemableItemRemoteDataSource {
  Future<RedeemableItemModel> fetchAllRedeemableItems(int? page, int? limit);
  Future<String> redeemItems(String memberCode, String itemId);
}

class RedeemableItemRemoteDataSourceImpl implements RedeemableItemRemoteDataSource {
  Dio dio;
  RedeemableItemRemoteDataSourceImpl(this.dio);
  @override
  Future<RedeemableItemModel> fetchAllRedeemableItems(int? page, int? limit) async {
    try {
      var queryParams = {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        "sortType": 'dsc'
      };
      var response = await dio.get(redeemableItemPaginatedAPI, queryParameters: queryParams);
      return RedeemableItemModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDEFARI] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFARI] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<String> redeemItems(String memberCode, String itemId) async {
    try {
      var result =
          await dio.post(redeemItemMemberAPI, data: {"member_code": memberCode, "item_id": itemId});
      return result.data['redeemCode'];
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDERI] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCERI] We got some problems with our service, Try again later');
    }
  }
}
