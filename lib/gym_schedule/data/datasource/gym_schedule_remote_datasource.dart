import 'package:gym_guardian_membership/gym_schedule/data/models/calendar_event_data.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

abstract class GymScheduleRemoteDataSource {
  Future<List<CalendarEventData>> fetchEventSchedule();
  Future<String> reservationEventSchedule(String event, String memberCode);
  Future<String> cancelReservationEventSchedule(String event, String memberCode);
}

class GymScheduleRemoteDataSourceImpl implements GymScheduleRemoteDataSource {
  Dio dio;
  GymScheduleRemoteDataSourceImpl(this.dio);
  @override
  Future<List<CalendarEventData>> fetchEventSchedule() async {
    try {
      var result = await dio.get(eventScheduleAPI);
      return List<CalendarEventData>.from(result.data.map((e) => CalendarEventData.fromJson(e)));
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDEFES] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCEFES] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<String> reservationEventSchedule(String event, String memberCode) async {
    try {
      await dio
          .post("$eventScheduleAPI/reservation", data: {"member_code": memberCode, "event": event});
      return "reservation has been successfully";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDERES] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCERES] We got some problems with our service, Try again later');
    }
  }

  @override
  Future<String> cancelReservationEventSchedule(String event, String memberCode) async {
    try {
      await dio.delete("$eventScheduleAPI/reservation",
          queryParameters: {"member_code": memberCode, "event": event});
      return "cancel reservation has been successfully";
    } on DioException catch (e) {
      throw DatabaseException(
          e.response?.data ?? '[DSDECRES] We Cant Communication with Server, Try again later');
    } catch (e) {
      throw CommonException('[DSCECRES] We got some problems with our service, Try again later');
    }
  }
}
