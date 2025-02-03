import 'package:gym_guardian_membership/detail_point/data/datasource/detail_point_local_datasource.dart';
import 'package:gym_guardian_membership/detail_point/data/datasource/detail_point_remote_datasource.dart';
import 'package:gym_guardian_membership/detail_point/data/repository/detail_point_repository.dart';
import 'package:gym_guardian_membership/detail_point/domain/repository/repository.dart';
import 'package:gym_guardian_membership/detail_point/domain/usecase/fetch_point_history_by_code.dart';
import 'package:gym_guardian_membership/detail_point/presentation/bloc/fetch_detail_point_bloc/fetch_detail_point_bloc.dart';
import 'package:gym_guardian_membership/homepage/data/datasource/homepage_local_datasource.dart';
import 'package:gym_guardian_membership/homepage/data/datasource/homepage_remote_datasource.dart';
import 'package:gym_guardian_membership/homepage/data/repository/homepage_repository.dart';
import 'package:gym_guardian_membership/homepage/domain/repository/repository.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/cancel_booking.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/check_booking_slot_left.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_activity_member_by_code.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_all_gym_equipment.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_booking_member.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_detail_member_by_email.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/logout_member.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/register_attendance.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/request_booking.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/cancel_booking_bloc/cancel_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/check_booking_slot_left_bloc/check_booking_slot_left_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/detail_attendance_history/presentation/bloc/fetch_activity_member_bloc/fetch_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_all_gym_equipment_bloc/fetch_all_gym_equipment_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_activity_member_bloc/fetch_last_three_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_booking_bloc/fetch_last_three_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/logout_member_bloc/logout_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/register_attendance_bloc/register_attendance_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/request_booking_bloc/request_booking_bloc.dart';
import 'package:gym_guardian_membership/local_storage.dart';
import 'package:gym_guardian_membership/login/data/datasource/login_local_datasource.dart';
import 'package:gym_guardian_membership/login/data/datasource/login_remote_datasource.dart';
import 'package:gym_guardian_membership/login/data/repository/login_repository.dart';
import 'package:gym_guardian_membership/login/domain/repository/repository.dart';
import 'package:gym_guardian_membership/login/domain/usecase/login_member.dart';
import 'package:gym_guardian_membership/login/presentation/bloc/login_member_bloc/login_member_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/data/datasource/pricing_plan_local_datasource.dart';
import 'package:gym_guardian_membership/pricing_plan/data/datasource/pricing_plan_remote_datasource.dart';
import 'package:gym_guardian_membership/pricing_plan/data/repository/pricing_plan_repository.dart';
import 'package:gym_guardian_membership/pricing_plan/domain/repository/repository.dart';
import 'package:gym_guardian_membership/pricing_plan/domain/usecase/fetch_all_pricing_plan.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/bloc/fetch_all_pricing_plan_bloc/fetch_all_pricing_plan_bloc.dart';
import 'package:gym_guardian_membership/profile/data/datasource/profile_local_datasource.dart';
import 'package:gym_guardian_membership/profile/data/datasource/profile_remote_datasource.dart';
import 'package:gym_guardian_membership/profile/data/repository/profile_repository.dart';
import 'package:gym_guardian_membership/profile/domain/repository/repository.dart';
import 'package:gym_guardian_membership/profile/domain/usecase/update_profile.dart';
import 'package:gym_guardian_membership/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:gym_guardian_membership/redeem_history/data/datasource/redeem_history_local_datasource.dart';
import 'package:gym_guardian_membership/redeem_history/data/datasource/redeem_history_remote_datasource.dart';
import 'package:gym_guardian_membership/redeem_history/data/repository/redeem_history_repository.dart';
import 'package:gym_guardian_membership/redeem_history/domain/repository/repository.dart';
import 'package:gym_guardian_membership/redeem_history/domain/usecase/cancel_redeem_item.dart';
import 'package:gym_guardian_membership/redeem_history/domain/usecase/fetch_all_redeem_history.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/bloc/cancel_redeem_item_bloc/cancel_redeem_item_bloc.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/bloc/fetch_all_redeem_history_bloc/fetch_all_redeem_history_bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/data/datasource/reedemable_item_local_datasource.dart';
import 'package:gym_guardian_membership/redeemable_item/data/datasource/reedemable_item_remote_datasource.dart';
import 'package:gym_guardian_membership/redeemable_item/data/repository/redeemable_item_repository.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/repository/repository.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/usecase/fetch_all_redeemable_item.dart';
import 'package:gym_guardian_membership/redeemable_item/domain/usecase/redeem_item.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/bloc/fetch_all_redeemable_item_bloc/fetch_all_redeemable_item_bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/bloc/redeem_item_bloc/redeem_item_bloc.dart';
import 'package:gym_guardian_membership/register/data/datasource/register_local_datasource.dart';
import 'package:gym_guardian_membership/register/data/datasource/register_remote_datasource.dart';
import 'package:gym_guardian_membership/register/data/repository/register_repository.dart';
import 'package:gym_guardian_membership/register/domain/repository/repository.dart';
import 'package:gym_guardian_membership/register/domain/usecase/register_member.dart';
import 'package:gym_guardian_membership/register/presentation/bloc/register_member_bloc/register_member_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';

import 'package:os_basecode/os_basecode.dart';

var locator = GetIt.instance;

Future<void> initSharedPref() async {
  locator.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
}

void initLocator() {
  locator.registerLazySingleton<Client>(() {
    return Client(
        baseURL: "${baseURL}api/",
        accessTokenKey: accessToken,
        connectTimeout: 10.seconds,
        showLogging: true,
        handleWhenUnauthorized: () async {
          LocalStorage(locator()).removeAllItem();
          // Arahkan ke halaman login
          if (parentKey.currentContext != null) {
            parentKey.currentContext?.go("/login", extra: 'Unauthorized');
          }
        });
  });
  locator.registerLazySingleton<Dio>(() => locator<Client>().dioService);

  //REGISTE
  locator.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<RegisterLocalDataSource>(() => RegisterLocalDataSourceImpl());
  locator.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<RegisterMemberBloc>(() => RegisterMemberBloc(locator()));
  locator.registerLazySingleton<RegisterMemberUsecase>(() => RegisterMemberUsecase(locator()));

//PRICING
  locator.registerLazySingleton<PricingPlanRepository>(
      () => PricingPlanRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<PricingPlanLocalDataSource>(() => PricingPlanLocalDataSourceImpl());
  locator.registerLazySingleton<PricingPlanRemoteDataSource>(
      () => PricingPlanRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<FetchAllPricingPlanUsecase>(
      () => FetchAllPricingPlanUsecase(locator()));
  locator.registerLazySingleton<FetchAllPricingPlanBloc>(() => FetchAllPricingPlanBloc(locator()));

//LOGIN
  locator.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<LoginLocalDataSource>(() => LoginLocalDataSourceImpl());
  locator.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<LoginMemberUsecase>(() => LoginMemberUsecase(locator()));
  locator.registerLazySingleton<LoginMemberBloc>(() => LoginMemberBloc(locator()));

//HOMEPAGE
  locator.registerLazySingleton<HomepageRepository>(
      () => HomepageRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<HomepageLocalDataSource>(() => HomepageLocalDataSourceImpl());
  locator.registerLazySingleton<HomepageRemoteDataSource>(
      () => HomepageRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<FetchDetailMemberByEmailUsecase>(
      () => FetchDetailMemberByEmailUsecase(locator()));
  locator.registerLazySingleton<FetchActivityMemberByCodeUsecase>(
      () => FetchActivityMemberByCodeUsecase(locator()));
  locator.registerLazySingleton<CheckBookingSlotLeftUsecase>(
      () => CheckBookingSlotLeftUsecase(locator()));
  locator.registerLazySingleton<RequestBookingUsecase>(() => RequestBookingUsecase(locator()));
  locator.registerLazySingleton<DetailMemberBloc>(() => DetailMemberBloc(locator(), locator()));
  locator.registerLazySingleton<RequestBookingBloc>(() => RequestBookingBloc(locator()));
  locator.registerLazySingleton<FetchActivityMemberBloc>(() => FetchActivityMemberBloc(locator()));
  locator.registerLazySingleton<FetchBookingUsecase>(() => FetchBookingUsecase(locator()));
  locator.registerLazySingleton<FetchAllGymEquipmentUsecase>(
      () => FetchAllGymEquipmentUsecase(locator()));
  locator
      .registerLazySingleton<FetchAllGymEquipmentBloc>(() => FetchAllGymEquipmentBloc(locator()));
  locator.registerLazySingleton<FetchBookingBloc>(() => FetchBookingBloc(locator()));
  locator.registerLazySingleton<CancelBookingUsecase>(() => CancelBookingUsecase(locator()));
  locator.registerLazySingleton<CancelBookingBloc>(() => CancelBookingBloc(locator()));
  locator.registerLazySingleton<LogoutMemberUsecase>(() => LogoutMemberUsecase(locator()));
  locator
      .registerLazySingleton<RegisterAttendanceUsecase>(() => RegisterAttendanceUsecase(locator()));
  locator.registerLazySingleton<RegisterAttendanceBloc>(() => RegisterAttendanceBloc(locator()));
  locator.registerLazySingleton<LogoutMemberBloc>(() => LogoutMemberBloc(locator(), locator()));
  locator
      .registerLazySingleton<FetchLastThreeBookingBloc>(() => FetchLastThreeBookingBloc(locator()));
  locator.registerLazySingleton<FetchLastThreeActivityMemberBloc>(
      () => FetchLastThreeActivityMemberBloc(locator()));
  locator
      .registerLazySingleton<CheckBookingSlotLeftBloc>(() => CheckBookingSlotLeftBloc(locator()));

//DETAIL POINT
  locator.registerLazySingleton<DetailPointRepository>(
      () => DetailPointRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<DetailPointLocalDataSource>(() => DetailPointLocalDataSourceImpl());
  locator.registerLazySingleton<DetailPointRemoteDataSource>(
      () => DetailPointRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<FetchPointHistoyByCodeUsecase>(
      () => FetchPointHistoyByCodeUsecase(locator()));
  locator.registerLazySingleton<FetchDetailPointBloc>(() => FetchDetailPointBloc(locator()));

//REDEEMABLE ITEM
  locator.registerLazySingleton<RedeemableItemRepository>(
      () => RedeemableItemRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<RedeemableItemLocalDataSource>(
      () => RedeemableItemLocalDataSourceImpl());
  locator.registerLazySingleton<RedeemableItemRemoteDataSource>(
      () => RedeemableItemRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<FetchAllRedeemableItemUsecase>(
      () => FetchAllRedeemableItemUsecase(locator()));
  locator.registerLazySingleton<RedeemItemUsecase>(() => RedeemItemUsecase(locator()));
  locator.registerLazySingleton<FetchAllRedeemableItemBloc>(
      () => FetchAllRedeemableItemBloc(locator()));
  locator.registerLazySingleton<RedeemItemBloc>(() => RedeemItemBloc(locator()));

  //PROFILE
  locator
      .registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<ProfileLocalDataSource>(() => ProfileLocalDataSourceImpl());
  locator
      .registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<UpdateProfileUsecase>(() => UpdateProfileUsecase(locator()));
  locator.registerLazySingleton<UpdateProfileBloc>(() => UpdateProfileBloc(locator()));

  locator.registerLazySingleton<RedeemHistoryRepository>(
      () => RedeemHistoryRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<RedeemHistoryLocalDataSource>(
      () => RedeemHistoryLocalDataSourceImpl());
  locator
      .registerLazySingleton<RedeemHistoryRemoteDataSource>(() => RedeemHistoryRemoteDataSourceImpl(
            locator(),
          ));
  locator.registerLazySingleton<FetchAllRedeemHistoryUsecase>(() => FetchAllRedeemHistoryUsecase(
        locator(),
      ));
  locator.registerLazySingleton<FetchAllRedeemHistoryBloc>(() => FetchAllRedeemHistoryBloc(
        locator(),
      ));
  locator.registerLazySingleton<CancelRedeemItemUsecase>(() => CancelRedeemItemUsecase(
        locator(),
      ));
  locator.registerLazySingleton<CancelRedeemItemBloc>(() => CancelRedeemItemBloc(
        locator(),
      ));
  locator.registerLazySingleton<ChatHistoryBloc>(() => ChatHistoryBloc(
        locator(),
      ));
}
