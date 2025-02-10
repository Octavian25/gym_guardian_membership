import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (payload != null) {
    dev.log('Notification payload: $payload', name: "NOTIFICATION HANDLER");
  }
}

class NotificationHandler {
  static final NotificationHandler _instance = NotificationHandler._internal();

  factory NotificationHandler() => _instance;

  NotificationHandler._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Gunakan icon yang ada di mipmap

    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      return await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission() ??
          false;
    }
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
        false;
  }

  Future<bool> turnOffNotification() async {
    if (Platform.isAndroid) {
      return await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission() ??
          false;
    }
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: false,
              badge: false,
              sound: false,
            ) ??
        false;
  }

  Future<bool> requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<bool> requestFullScreenIntentPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestFullScreenIntentPermission() ??
        false;
  }

  Future<NotificationsEnabledOptions?> checkPermissionStatusIOS() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.checkPermissions();
  }

  Future<bool?> checkPermissionStatusAndroid() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();
  }

  Future<void> clearAllNotification() async {
    return await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> showNotification(String title, String body,
      {String? threadIdentifier,
      String? channelId,
      String? channelName,
      String? channelDescription,
      String? payload}) async {
    const int notificationId = 1001; // Bisa dibuat random untuk banyak notifikasi

    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "gym_guardian", // Pastikan konsisten dengan channel ID
      "Gym Guardian Notification",
      channelDescription: "This is Gym Guardian Notification Channel",
      importance: Importance.max,
      priority: Priority.high,
    );

    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      threadIdentifier: threadIdentifier,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> showScheduledNotification(String title, String body,
      {required int intervalDays, // Berapa hari sekali notifikasi muncul
      required int hour, // Jam yang diinginkan user (0-23)
      required int minute, // Menit yang diinginkan user (0-59)
      String? threadIdentifier,
      String? channelId,
      String? channelName,
      String? channelDescription,
      String? payload}) async {
    try {
      int notificationId = 200; // ID random agar tidak replace notifikasi lain

      tz.TZDateTime scheduledDate = _nextScheduledTime(intervalDays, hour, minute);

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channelId ?? "gym_guardian",
        channelName ?? "Gym Guardian Notification",
        channelDescription: channelDescription ?? "This is Gym Guardian Notification Channel",
        importance: Importance.max,
        priority: Priority.high,
      );

      DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        threadIdentifier: threadIdentifier,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        title,
        body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents:
            DateTimeComponents.dayOfWeekAndTime, // Agar tetap berulang di hari & jam yang sama
        payload: payload,
      );
      dev.log("Notifikasi dijadwalkan pada: $scheduledDate", name: "NOTIFICATION HELPER");
    } catch (e, s) {
      dev.log("Error", error: e, stackTrace: s, name: "NOTIFICATION HELPER");
    }
  }

  Future<void> showEventReminderNotification(
    String title,
    String body, {
    required DateTime eventDateTime, // Waktu event
    required int reminderMinutesBefore, // Berapa menit sebelum event notifikasi muncul
    String? threadIdentifier,
    String? channelId,
    String? channelName,
    String? channelDescription,
    String? payload,
  }) async {
    try {
      // Kurangi waktu event dengan `reminderMinutesBefore`
      tz.TZDateTime scheduledDate = tz.TZDateTime.from(
          eventDateTime.subtract(Duration(minutes: reminderMinutesBefore)), tz.local);

      // ID notifikasi random agar tidak menimpa yang lain
      int notificationId = eventDateTime.millisecondsSinceEpoch ~/ 1000;

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channelId ?? "gym_guardian_event",
        channelName ?? "Gym Guardian Event Reminder",
        channelDescription: channelDescription ?? "Pengingat kedatangan event Gym Guardian",
        importance: Importance.max,
        priority: Priority.high,
      );

      DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        threadIdentifier: threadIdentifier,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        title,
        body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );

      dev.log("Notifikasi event dijadwalkan pada: $scheduledDate", name: "EVENT NOTIFICATION");
    } catch (e, s) {
      dev.log("Error scheduling event notification",
          error: e, stackTrace: s, name: "EVENT NOTIFICATION");
    }
  }

  tz.TZDateTime _nextScheduledTime(int intervalDays, int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    scheduledDate = scheduledDate.add(Duration(days: intervalDays));
    return scheduledDate;
  }
}
