import 'package:os_basecode/os_basecode.dart';
import 'package:gym_guardian_membership/detail_point/presentation/bloc/fetch_detail_point_bloc/fetch_detail_point_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/cancel_booking_bloc/cancel_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/check_booking_slot_left_bloc/check_booking_slot_left_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/detail_attendance_history/presentation/bloc/fetch_activity_member_bloc/fetch_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_booking_bloc/fetch_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_activity_member_bloc/fetch_last_three_activity_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_last_three_booking_bloc/fetch_last_three_booking_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/logout_member_bloc/logout_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/register_attendance_bloc/register_attendance_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/request_booking_bloc/request_booking_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/bloc/login_member_bloc/login_member_bloc.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/preview_registration_bloc/preview_registration_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/bloc/fetch_all_pricing_plan_bloc/fetch_all_pricing_plan_bloc.dart';
import 'package:gym_guardian_membership/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/bloc/fetch_all_redeemable_item_bloc/fetch_all_redeemable_item_bloc.dart';
import 'package:gym_guardian_membership/register/presentation/bloc/register_member_bloc/register_member_bloc.dart';
import 'injector.dart' as di;

var listProviders = [
  BlocProvider(
    create: (context) => di.locator<FetchAllPricingPlanBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<RegisterMemberBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<LoginMemberBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<DetailMemberBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<FetchActivityMemberBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<CheckBookingSlotLeftBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<RequestBookingBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<FetchBookingBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<CancelBookingBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<FetchLastThreeActivityMemberBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<FetchLastThreeBookingBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<LogoutMemberBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<FetchDetailPointBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<RegisterAttendanceBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<FetchAllRedeemableItemBloc>(),
  ),
  BlocProvider(
    create: (context) => di.locator<UpdateProfileBloc>(),
  ),
  BlocProvider(
    create: (context) => PreviewRegistrationBloc(),
  )
];
