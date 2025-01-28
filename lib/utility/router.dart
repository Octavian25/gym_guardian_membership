import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/detail_attendance_history/presentation/pages/detail_attendance_history_screen.dart';
import 'package:gym_guardian_membership/detail_coupon/presentation/pages/detail_coupon_screen.dart';
import 'package:gym_guardian_membership/detail_level/presentation/pages/detail_level_screen.dart';
import 'package:gym_guardian_membership/detail_point/presentation/pages/detail_point_screen.dart';
import 'package:gym_guardian_membership/forgot_password/presentation/pages/forgot_password_screen.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/pages/homepage_screen.dart';
import 'package:gym_guardian_membership/login/presentation/pages/login_screen.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/pages/preview_registration_screen.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/profile/presentation/pages/profile_screen.dart';
import 'package:gym_guardian_membership/redeem_history/presentation/pages/redeem_history_screen.dart';
import 'package:gym_guardian_membership/redeemable_item/presentation/pages/redeemable_item_screen.dart';
import 'package:gym_guardian_membership/register/presentation/pages/register_screen.dart';
import 'package:gym_guardian_membership/shell_screen.dart';
import 'package:gym_guardian_membership/splashscreen/presentation/pages/splashscreen_screen.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/verify_account/presentation/pages/verify_account_screen.dart';
import 'package:os_basecode/os_basecode.dart';

GlobalKey<NavigatorState> parentKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> shellKey = GlobalKey<NavigatorState>();

GoRouter goRouter = GoRouter(navigatorKey: parentKey, initialLocation: "/splashscreen", routes: [
  GoRoute(
    path: "/splashscreen",
    builder: (context, state) => SplashScreen(),
    redirect: (context, state) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
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
              )
            ]),
        GoRoute(
          path: "/profile",
          builder: (context, state) => ProfileScreen(),
        )
      ])
]);

void closeAllDialogs(BuildContext context) {
  while (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}
