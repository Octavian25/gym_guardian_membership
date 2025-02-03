import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/body_metrics/presentation/pages/body_metrics_screen.dart';
import 'package:gym_guardian_membership/detail_attendance_history/presentation/pages/detail_attendance_history_screen.dart';
import 'package:gym_guardian_membership/detail_coupon/presentation/pages/detail_coupon_screen.dart';
import 'package:gym_guardian_membership/detail_level/presentation/pages/detail_level_screen.dart';
import 'package:gym_guardian_membership/detail_point/presentation/pages/detail_point_screen.dart';
import 'package:gym_guardian_membership/forgot_password/presentation/pages/forgot_password_screen.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_all_gym_equipment_bloc/fetch_all_gym_equipment_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/pages/homepage_screen.dart';
import 'package:gym_guardian_membership/login/presentation/pages/login_screen.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/pages/preview_registration_screen.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/profile/presentation/pages/profile_screen.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/pages/redeem_history_screen.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/pages/redeemable_item_screen.dart';
import 'package:gym_guardian_membership/register/presentation/pages/register_screen.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/arm_circumference_page.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/body_fat_page.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/chest_circumference_page.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/height_page.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/register_body_measurement_tracker_screen.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/thigh_circumference_page.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/waist_circumference_page.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/weight_page.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/pages/welcome_page_body_measurement.dart';
import 'package:gym_guardian_membership/shell_screen.dart';
import 'package:gym_guardian_membership/splashscreen/presentation/pages/splashscreen_screen.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/verify_account/presentation/pages/verify_account_screen.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/pages/workout_recommendation_screen.dart';
import 'package:os_basecode/os_basecode.dart';

GlobalKey<NavigatorState> parentKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> shellKey = GlobalKey<NavigatorState>();

GoRouter goRouter = GoRouter(navigatorKey: parentKey, initialLocation: "/splashscreen", routes: [
  GoRoute(
    path: "/splashscreen",
    builder: (context, state) => SplashScreen(),
    redirect: (context, state) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      context.read<FetchAllGymEquipmentBloc>().add(DoFetchAllGymEquipment(null));
      final isSplashFinish = pref.getBool("FINISH_SPLASH") ?? false;
      if (isSplashFinish) {
        return "/login";
      }
      final token = pref.getString(accessToken);
      if (token != null && token.isNotEmpty) {
        // Jika accessToken tersedia, redirect ke /homepage
        // ignore: use_build_context_synchronously
        context.read<DetailMemberBloc>().add(DoDetailMember());
        return "/homepage";
      }
      // Tetap di halaman login jika tidak ada accessToken
      return null;
    },
  ),
  GoRoute(path: "/login", builder: (context, state) => LoginScreen(), routes: [
    GoRoute(path: "register", builder: (context, state) => RegisterScreen(), routes: [
      GoRoute(path: "pricing", builder: (context, state) => PricingPlanScreen(), routes: [
        GoRoute(
          path: "preview",
          builder: (context, state) => PreviewRegistrationScreen(),
        ),
      ]),
    ]),
    GoRoute(path: "forgot-password", builder: (context, state) => ForgotPasswordScreen(), routes: [
      GoRoute(
        path: "verify-otp",
        builder: (context, state) => VerifyAccountScreen(),
      )
    ])
  ]),
  ShellRoute(
      navigatorKey: shellKey,
      parentNavigatorKey: parentKey,
      builder: (context, state, child) {
        return ShellScreen(
            body: child, activeIndex: state.uri.toString().contains("/homepage") ? 0 : 1);
      },
      routes: [
        GoRoute(
            path: "/homepage",
            builder: (context, state) => HomepageScreen(
                  extra: state.extra as String?,
                ),
            routes: [
              GoRoute(
                  path: "detail-points",
                  builder: (context, state) => DetailPointScreen(),
                  routes: [
                    GoRoute(
                        path: "redeem",
                        builder: (context, state) => RedeemableItemScreen(),
                        routes: [
                          GoRoute(
                            path: "history",
                            builder: (context, state) => RedeemHistoryScreen(),
                          )
                        ]),
                  ]),
              GoRoute(
                path: "detail-coupon",
                builder: (context, state) => DetailCouponScreen(),
              ),
              GoRoute(
                path: "detail-level",
                builder: (context, state) => DetailLevelScreen(
                  currentLevel: state.extra as String,
                ),
              ),
              GoRoute(
                path: "detail-attendance",
                builder: (context, state) => DetailAttendanceHistoryScreen(),
              ),
            ]),
        GoRoute(
          path: "/profile",
          builder: (context, state) => ProfileScreen(),
        )
      ]),
  GoRoute(
    path: "/workout-assistance",
    builder: (context, state) => WorkoutRecommendationScreen(),
  ),
  GoRoute(path: "/body-metrics", builder: (context, state) => BodyMetricsScreen(), routes: [
    ShellRoute(
        builder: (context, state, child) {
          return RegisterBodyMeasurementTracker(
            body: child,
            currentIndex: getBodyMeasureIndex(state.uri.toString()),
          );
        },
        routes: [
          GoRoute(
              path: "register-body-measurements-tracker",
              builder: (context, state) => WelcomePageRegisterBodymeasurement(),
              routes: [
                GoRoute(
                  path: 'weight',
                  builder: (context, state) => WeightRegisterBodymeasurement(),
                ),
                GoRoute(
                  path: 'height',
                  builder: (context, state) => HeightRegisterBodymeasurement(),
                ),
                GoRoute(
                  path: 'chest-circumference',
                  builder: (context, state) => ChestCirfumferenceRegisterBodymeasurement(),
                ),
                GoRoute(
                  path: 'waist-circumference',
                  builder: (context, state) => WaistCirfumferenceRegisterBodymeasurement(),
                ),
                GoRoute(
                  path: 'thigh-circumference',
                  builder: (context, state) => ThighCirfumferenceRegisterBodymeasurement(),
                ),
                GoRoute(
                  path: 'arm-circumference',
                  builder: (context, state) => ArmCirfumferenceRegisterBodymeasurement(),
                ),
                GoRoute(
                  path: 'body-fat',
                  builder: (context, state) => BodyFatRegisterBodymeasurement(),
                )
              ])
        ])
  ])
]);

void closeAllDialogs(BuildContext context) {
  while (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}

int getBodyMeasureIndex(String uri) {
  switch (uri) {
    case "/body-metrics/register-body-measurements-tracker/height":
      return 1;
    case "/body-metrics/register-body-measurements-tracker/weight":
      return 2;
    default:
      return 0;
  }
}
