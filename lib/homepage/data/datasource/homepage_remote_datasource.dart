import 'package:gym_guardian_membership/homepage/data/models/activity_member_model.dart';
import 'package:gym_guardian_membership/homepage/data/models/booking_model.dart';
import 'package:gym_guardian_membership/homepage/data/models/register_attendance_response_model.dart';
import 'package:gym_guardian_membership/register/data/models/member_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class HomepageRemoteDataSource {
  Future<MemberModel> fetchDetailMemberByEmail(String memberEmail);
  Future<ActivityMemberModel> fetchActivityMemberByCode(String memberCode, int? page, int? limit);
  Future<int> checkBookingSlotLeft();
  Future<String> requestBooking(String memberCode, String bookingDate);
  Future<String> cancelBooking(String id);
  Future<BookingModel> fetchAllBookings(String memberCode, int? page, int? limit);
  Future<String> logoutMember(String userId, String refreshToken);
  Future<RegisterAttendanceResponseModel> registerAttendance(String memberCode);
}

class HomepageRemoteDataSourceImpl implements HomepageRemoteDataSource {
  Dio dio;
  HomepageRemoteDataSourceImpl(this.dio);
  @override
  Future<MemberModel> fetchDetailMemberByEmail(String memberEmail) async {
    try {
      var result =
          await dio.get(checkMemberByEmailAPI, queryParameters: {"member_email": memberEmail});

      return MemberModel.fromJson(result.data);
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDEFDMBE] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFDMBE] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<ActivityMemberModel> fetchActivityMemberByCode(
      String memberCode, int? page, int? limit) async {
    try {
      var queryParams = {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        "sortType": 'dsc'
      };
      var response =
          await dio.get("$activitiesByEmailAPI$memberCode", queryParameters: queryParams);
      return ActivityMemberModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDEFAMBC] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFAMBC] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<int> checkBookingSlotLeft() async {
    try {
      var response = await dio.get(checkBookingSlotLeftAPI);
      return response.data;
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDECBSL] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCECBSL] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<String> requestBooking(String memberCode, String bookingDate) async {
    try {
      await dio.post(bookingsAPI, data: {"member_code": memberCode, "booking_date": bookingDate});
      return "Your booking has been successfully completed! We look forward to seeing you soon. Thank you for choosing our service!";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDERB] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCERB] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<BookingModel> fetchAllBookings(String memberCode, int? page, int? limit) async {
    try {
      var queryParams = {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        "sortType": 'dsc'
      };
      var response = await dio.get("$bookingByCodeAPI$memberCode", queryParameters: queryParams);
      return BookingModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DatabaseException(e.response?.data['message'] ??
          '[DSDEFAB] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFAB] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<String> cancelBooking(String id) async {
    try {
      await dio.delete("$bookingsAPI/$id");
      return "Your booking has been successfully canceled. We hope to assist you again in the future. Thank you for using our service!";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDEDB] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEDB] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<String> logoutMember(String userId, String refreshToken) async {
    try {
      await dio.post(logoutAPI, data: {"user_id": userId, "refresh_token": refreshToken});
      return "Your account has been logged out from the server";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDELOM] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCELOM] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<RegisterAttendanceResponseModel> registerAttendance(String memberCode) async {
    try {
      var response = await dio.get("$memberAttendanceAPI/$memberCode");
      return RegisterAttendanceResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDERA] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCERA] We got some problems with our service, Try again later');
    }
  }
}
