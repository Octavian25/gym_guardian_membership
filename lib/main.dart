import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/bloc/fetch_body_measurement_bloc/fetch_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/detail_point/presentation/bloc/fetch_detail_point_bloc/fetch_detail_point_bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/cancel_reservation_event_schedule_bloc/cancel_reservation_event_schedule_bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/fetch_event_schedule_bloc/fetch_event_schedule_bloc.dart';
import 'package:gym_guardian_membership/gym_schedule/presentation/bloc/reservation_event_schedule_bloc/reservation_event_schedule_bloc.dart';
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
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/bloc/body_measurement_bloc/body_measurement_bloc.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/bloc/register_body_measurement_bloc/register_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/splashscreen/presentation/bloc/get_system_data_bloc/get_system_data_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:gym_guardian_membership/utility/locale_provider.dart';

import 'package:gym_guardian_membership/utility/notification_handler.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:os_basecode/os_basecode.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/date_symbol_data_local.dart';
import 'package:os_permission_widget/os_permission_widget.dart';
import 'package:os_updater/os_updater.dart';
import 'package:provider/provider.dart';
import 'package:y_player/y_player.dart';
import 'injector.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: geminiKey);
  printAllGeminiModels();
  await di.initSharedPref();
  await di.locator.allReady();
  if (!di.locator.allReadySync()) {
    throw Exception("There is not enough time to initialize injector");
  }
  di.initLocator();
  NotificationHandler().initNotification(); // Inisialisasi notifikasi

  UpdateManager.initialize('https://103.150.191.156:8729',
      appsKey: "7YG6Uqz8E5p4TmcjFQspZv48140wDEfI", splittedAPK: true);
  // Inisialisasi locale berdasarkan sistem perangkat
  await initializeDateFormatting();
  YPlayerInitializer.ensureInitialized();
  await Permission.speech.request();
  await Permission.microphone.request();
  Intl.defaultLocale = WidgetsBinding.instance.platformDispatcher.locale.toString();
  runApp(ChangeNotifierProvider(create: (context) => LocaleProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
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
          create: (context) => di.locator<ChatHistoryBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<FetchAllGymEquipmentBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<RegisterBodyMeasurementBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<FetchBodyMeasurementBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<FetchEventScheduleBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<ReservationEventScheduleBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<CancelReservationEventScheduleBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetSystemDataBloc>(),
        ),
        BlocProvider(
          create: (context) => PreviewRegistrationBloc(),
        ),
        BlocProvider(
          create: (context) => WorkoutSuggestionsBloc(),
        ),
        BlocProvider(
          create: (context) => BodyMeasurementBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        splitScreenMode: false,
        ensureScreenSize: true,
        builder: (context, child) {
          return CalendarControllerProvider(
            controller: EventController(),
            child: MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              routeInformationProvider: goRouter.routeInformationProvider,
              routeInformationParser: goRouter.routeInformationParser,
              routerDelegate: goRouter.routerDelegate,
              locale: localeProvider.locale,
              localeResolutionCallback: (locale, supportedLocales) {
                // Cek apakah locale yang didukung ada di daftar supportedLocales
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                }
                // Jika tidak didukung, gunakan locale default (misalnya, Indonesia)
                return const Locale('en');
              },
              title: 'Gym Guardian Membership',
              theme: ThemeData(
                  appBarTheme:
                      AppBarTheme(backgroundColor: Colors.white, shadowColor: Colors.white),
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: "#B0C929".toColor(),
                      primary: "#B0C929".toColor(),
                      onPrimary: onPrimaryColor),
                  useMaterial3: true,
                  navigationBarTheme:
                      NavigationBarThemeData(labelTextStyle: WidgetStateTextStyle.resolveWith(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
                      } else {
                        return TextStyle(fontSize: 12, color: Colors.black54);
                      }
                    },
                  )),
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
            ),
          );
        },
      ),
    );
  }
}
