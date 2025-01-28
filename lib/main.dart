import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
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
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/workout_suggestions_bloc/workout_suggestions_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/bloc/fetch_all_pricing_plan_bloc/fetch_all_pricing_plan_bloc.dart';
import 'package:gym_guardian_membership/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/bloc/cancel_redeem_item_bloc/cancel_redeem_item_bloc.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/bloc/fetch_all_redeem_history_bloc/fetch_all_redeem_history_bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/bloc/fetch_all_redeemable_item_bloc/fetch_all_redeemable_item_bloc.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/bloc/redeem_item_bloc/redeem_item_bloc.dart';
import 'package:gym_guardian_membership/register/presentation/bloc/register_member_bloc/register_member_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';
// ignore: depend_on_referenced_packagesπ
import 'package:intl/date_symbol_data_local.dart';
import 'package:os_updater/os_updater.dart';
import 'injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: geminiKey);

  await di.initSharedPref();
  await di.locator.allReady();
  if (!di.locator.allReadySync()) {
    throw Exception("There is not enough time to initialize injector");
  }
  di.initLocator();
  UpdateManager.initialize('https://103.150.191.156:8729',
      appsKey: "7YG6Uqz8E5p4TmcjFQspZv48140wDEfI", splittedAPK: true);
  // Inisialisasi locale berdasarkan sistem perangkat
  await initializeDateFormatting();
  Intl.defaultLocale = WidgetsBinding.instance.platformDispatcher.locale.toString();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          create: (context) => di.locator<RedeemItemBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<FetchAllRedeemHistoryBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<CancelRedeemItemBloc>(),
        ),
        BlocProvider(
          create: (context) => PreviewRegistrationBloc(),
        ),
        BlocProvider(
          create: (context) => WorkoutSuggestionsBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        splitScreenMode: false,
        ensureScreenSize: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationProvider: goRouter.routeInformationProvider,
            routeInformationParser: goRouter.routeInformationParser,
            routerDelegate: goRouter.routerDelegate,
            title: 'Loyality Membership',
            theme: ThemeData(
                appBarTheme: AppBarTheme(backgroundColor: Colors.white, shadowColor: Colors.white),
                scaffoldBackgroundColor: Colors.white,
                colorScheme: ColorScheme.fromSeed(
                    seedColor: "#B0C929".toColor(), primary: "#B0C929".toColor()),
                useMaterial3: true,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(10)))),
                filledButtonTheme: FilledButtonThemeData(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                textTheme: GoogleFonts.montserratTextTheme()),
          );
        },
      ),
    );
  }
}
