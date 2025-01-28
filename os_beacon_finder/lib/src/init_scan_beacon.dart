import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:os_beacon_finder/src/beacon_model.dart';
import 'package:os_beacon_finder/src/on_scanning_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

final Set<String> processedBeacons = {};
StreamController<BeaconModel?> eddystoneStreamController =
    StreamController<BeaconModel?>.broadcast();

Stream<BeaconModel?> get eddystoneStream => eddystoneStreamController.stream;

void disposeEddystoneStream() {
  if (!eddystoneStreamController.isClosed) {
    eddystoneStreamController.close();
  }
}

void resetEddystoneStreamController() {
  if (!eddystoneStreamController.isClosed) {
    eddystoneStreamController.close();
  }
  debugPrint("Restart Streaming");

  if (FlutterBluePlus.isScanningNow) {
    processedBeacons.clear();
    FlutterBluePlus.stopScan();
  }

  eddystoneStreamController = StreamController<BeaconModel?>.broadcast();
  eddystoneStreamController.add(null);
  hideScanningOverlay();
}

void stopEddystoneStreamController() {
  if (!eddystoneStreamController.isClosed) {
    eddystoneStreamController.close();
  }
  debugPrint("Restart Streaming");

  if (FlutterBluePlus.isScanningNow) {
    processedBeacons.clear();
    FlutterBluePlus.stopScan();
  }
  eddystoneStreamController = StreamController<BeaconModel?>.broadcast();
  eddystoneStreamController.add(null);
}

Future<void> initBeacon(BuildContext context, String title, String subtitle,
    {ButtonStyle? closeButtonStyle,
    Widget? closeButtonWidget,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    bool? showOverlay = false,
    String? specifyBeaconName}) async {
  processedBeacons.clear();
  if (!await FlutterBluePlus.isSupported) {
    debugPrint("Bluetooth not supported");
    return;
  }
  if (showOverlay ?? false) {
    if (!context.mounted) return;
    showScanningOverlay(
        context, title, subtitle, closeButtonStyle, closeButtonWidget, titleStyle, subtitleStyle);
  }

  FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
    log("Bluetooth state ${state.name}", name: "OS_BEACON_FINDER");
    if (state == BluetoothAdapterState.unknown) {
      // Tunggu hingga status berubah dari unknown
      log("Waiting for Bluetooth state to update...", name: "OS_BEACON_FINDER");
      return;
    }
    if (state == BluetoothAdapterState.on) {
      while (await Permission.location.isDenied) {
        if (!context.mounted) return;
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) => const RequestLocationOn(),
        );
      }
      startScanning();
    } else {
      if (!context.mounted) return;
      context.pop();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => const RequestBluetoothOn(),
      );
      hideScanningOverlay();
    }
  });

  // Dengarkan hasil pemindaian
  FlutterBluePlus.onScanResults.listen((results) {
    if (results.isNotEmpty) {
      for (ScanResult result in results) {
        parseBeaconData(result, specifyBeaconName);
      }
    }
  });
}

class RequestBluetoothOn extends StatelessWidget {
  const RequestBluetoothOn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              "packages/os_beacon_finder/assets/bluetooth.png",
              width: 0.4.sw,
            ),
          ),
          10.verticalSpacingRadius,
          Text(
            "Kami Membutuhkan Akses Bluetooth",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          const Text("Silahkan Aktifkan Bluetooth Anda"),
          20.verticalSpacingRadius,
          SizedBox(
              width: 1.sw,
              child: FilledButton(
                  onPressed: () async {
                    try {
                      if (!kIsWeb && Platform.isAndroid) {
                        await FlutterBluePlus.turnOn();
                      }
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Bluetooth diaktifkan. Silahkan coba lagi.")));
                      context.pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Bluetooth Tidak Aktif")));
                    }
                  },
                  child: const Text("Aktifkan Bluetooth"))),
        ],
      ),
    );
  }
}

class RequestLocationOn extends StatelessWidget {
  const RequestLocationOn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              "packages/os_beacon_finder/assets/radar.png",
              width: 0.4.sw,
            ),
          ),
          10.verticalSpacingRadius,
          Text(
            "Kami Membutuhkan Akses Lokasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          const Text("Silahkan berikan izin untuk akses lokasi"),
          20.verticalSpacingRadius,
          SizedBox(
              width: 1.sw,
              child: FilledButton(
                  onPressed: () async {
                    try {
                      var result = await Permission.location.request();
                      if (result.isGranted) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Lokasi diberikan izin")));
                      }
                      if (!context.mounted) return;
                      context.pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Lokasi Tidak Aktif")));
                    }
                  },
                  child: const Text("Aktifkan Bluetooth"))),
        ],
      ),
    );
  }
}

Future<void> startScanning() async {
  processedBeacons.clear();
  if (!FlutterBluePlus.isScanningNow) {
    debugPrint("Starting Bluetooth scan...");
    await FlutterBluePlus.startScan(
        withServices: [Guid("feaa")], androidUsesFineLocation: true, continuousUpdates: true);
  } else {
    debugPrint("Already scanning...");
  }
}

void parseBeaconData(ScanResult result, String? specifyBeaconName) {
  final serviceData = result.advertisementData.serviceData;
  if (serviceData.isNotEmpty) {
    for (var entry in serviceData.entries) {
      _handleEddystoneData(result, entry.value, specifyBeaconName);
    }
  }
}

void _handleEddystoneData(ScanResult result, List<int> data, String? specifyBeaconName) {
  try {
    final namespaceId = data.sublist(2, 12).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    final instanceId = data.sublist(12, 18).map((b) => b.toRadixString(16).padLeft(2, '0')).join();

    // if (!processedBeacons.contains(namespaceId)) {
    final rssi = result.rssi.toDouble();
    final distance = estimateDistance(rssi: rssi, txPowerAt1m: -57);
    log("txPower:${data[1]}", name: "OS_BEACON_FINDER");
    log("RSSI:$rssi", name: "OS_BEACON_FINDER");
    if (specifyBeaconName != null) {
      if (namespaceId != specifyBeaconName) {
        return;
      }
    }
    eddystoneStreamController.add(BeaconModel(
        distance: distance,
        txPower: data[1],
        rssi: rssi.floor(),
        instanceId: instanceId,
        namespaceId: namespaceId));

    processedBeacons.add(namespaceId);
    // checkAndShowNotification(namespaceId);
  } catch (e, s) {
    log("Error Handling Eddystone", error: e, stackTrace: s, name: "OS_BEACON_FINDER");
  }
}

double calculateDistance(double rssi) {
  const double n = 2; // Eksponen path loss
  const double A = -24; // Nilai RSSI pada 1 meter
  return pow(10, (A - rssi) / (10 * n)).toDouble();
}

/// Menghitung estimasi jarak (dalam meter) berdasarkan RSSI dan Tx Power.
///
/// [rssi] adalah RSSI yang diterima (misalnya -56 dBm).
/// [txPowerAt1m] adalah nilai Tx Power pada jarak 1 meter (misalnya -56 dBm).
/// [pathLossExponent] adalah faktor peredaman (default 2.0 untuk area agak terbuka).
double estimateDistance({
  required double rssi,
  required double txPowerAt1m,
  double pathLossExponent = 2.0,
}) {
  // Gunakan rumus jarak (log-distance)
  // distance = 10 ^ ((TxPower(1m) - RSSI) / (10 * n))
  final exponent = (txPowerAt1m - rssi) / (10 * pathLossExponent);
  final distance = pow(10, exponent);

  // Kembalikan dalam bentuk double
  return distance.toDouble();
}

void checkAndShowNotification(String namespaceId) async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now();

  // Ambil data notifikasi terakhir dari SharedPreferences
  final lastNotifications = prefs.getString('lastNotifications');
  Map<String, String> notificationData = {};

  if (lastNotifications != null) {
    notificationData = Map<String, String>.from(json.decode(lastNotifications));
  }

  // Ambil waktu notifikasi terakhir untuk namespaceId tertentu
  final lastNotificationTime =
      notificationData[namespaceId] != null ? DateTime.parse(notificationData[namespaceId]!) : null;

  // Periksa apakah notifikasi harus ditampilkan
  if (lastNotificationTime == null || now.difference(lastNotificationTime).inMinutes >= 10) {
    // Tampilkan notifikasi
    showNotification();

    // Perbarui data notifikasi
    notificationData[namespaceId] = now.toIso8601String();
    await prefs.setString('lastNotifications', json.encode(notificationData));
  }
}

void showNotification() {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Beacon Finder Notifications',
    description: 'This channel is used for Beacon Finder Notifications.',
    importance: Importance.max,
  );

  flutterLocalNotificationsPlugin.show(
    0,
    "Finder Ditemukan",
    "Silahkan Lakukan Aksi",
    NotificationDetails(
      android: AndroidNotificationDetails(channel.id, channel.name,
          channelDescription: channel.description),
    ),
  );
}
