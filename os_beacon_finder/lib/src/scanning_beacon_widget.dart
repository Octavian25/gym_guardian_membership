import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:os_beacon_finder/src/beacon_model.dart';
import 'package:os_beacon_finder/src/init_scan_beacon.dart';

class ScanningBeaconWidget extends StatefulWidget {
  final String? title;
  final String? descriptionTitle;
  final String? descriptionSubtitle;
  final String? distanceTitle;
  final String? cancelText;
  final Function(BeaconModel beaconDetail) handleBeaconFound;
  final Function(Object error, StackTrace stack) handelBeaconError;
  final Function() handelScanningBeaconDone;
  const ScanningBeaconWidget(
      {super.key,
      required this.title,
      this.descriptionSubtitle,
      this.distanceTitle,
      this.descriptionTitle,
      this.cancelText,
      required this.handleBeaconFound,
      required this.handelBeaconError,
      required this.handelScanningBeaconDone});

  @override
  State<ScanningBeaconWidget> createState() => _ScanningBeaconWidgetState();
}

class _ScanningBeaconWidgetState extends State<ScanningBeaconWidget> {
  StreamSubscription<BeaconModel?>? eddystoneSubscription;
  ValueNotifier<double?> distance = ValueNotifier<double?>(null);
  bool isSending = false;
  @override
  void initState() {
    super.initState();
    initBeacon(
        context,
        showOverlay: false,
        "Pencarian Berjalan",
        "Silahkan mendekat pada lokasi yang sudah ditentukan");

    eddystoneSubscription = eddystoneStream.listen((data) {
      if (data != null) {
        distance.value = data.distance;
        if (widget.title != null) {
          if (data.distance < 1.5) {
            if (!isSending) {
              try {
                if (!mounted) return;
                // handleOnBeaconFound
                log('BEACON FOUNDED', name: "OS_BEACON_FINDER");
                widget.handleBeaconFound(data);
              } catch (e, s) {
                // handleOnBeaconError
                widget.handelBeaconError(e, s);
              }
            }
            isSending = true;
          }
        }
      }
    }, onError: (e, s) {
      // handleOnBeaconError
      widget.handelBeaconError(e, s);
    }, onDone: () {
      if (!isSending) {
        // handleOnBeaconFinderDone
        widget.handelScanningBeaconDone();
      }
    });
  }

  @override
  void dispose() {
    stopEddystoneStreamController();
    distance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.title != null)
              Text(
                "${widget.title}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            10.verticalSpacingRadius,
            GestureDetector(
              child: RepaintBoundary(
                child: Image.asset(
                  "packages/os_beacon_finder/assets/radar.png",
                  width: 0.6.sw,
                ).animate(onPlay: (controller) => controller.repeat(), effects: [
                  ShakeEffect(hz: 2, duration: 2.seconds),
                  ShimmerEffect(
                      delay: 2.seconds, angle: 1, duration: 1.seconds, curve: Curves.easeInQuart),
                ]),
              ),
            ),
            10.verticalSpacingRadius,
            Text(
              widget.descriptionTitle ?? "Sedang Mencari Perangkat Absensi",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.descriptionSubtitle ?? "Silahkan mendekat ke lokasi yang sudah ditentukan",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.spMin),
            ),
            ValueListenableBuilder(
              valueListenable: distance,
              builder: (context, value, child) {
                if (value != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.verticalSpacingRadius,
                      Text(
                        widget.distanceTitle ?? "Jarak Lokasi Absen",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${value.toStringAsFixed(2)} m",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            10.verticalSpacingRadius,
            FilledButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(widget.cancelText ?? "Batal"))
          ],
        ),
      ),
    );
  }
}
