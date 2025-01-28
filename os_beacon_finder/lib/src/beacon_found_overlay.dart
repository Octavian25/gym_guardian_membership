import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

OverlayEntry? _overlayEntry;

void showBeaconResultOverlay(
    BuildContext context, String title, String subtitle, Function restartFunction) {
  if (_overlayEntry != null) return; // Mencegah overlay duplikasi

  _overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 1.sw - 20.dg,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(spreadRadius: 1, blurRadius: 5, color: Colors.black12),
            ],
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(fontSize: 9)),
                ],
              ),
              const Spacer(),
              FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue,
                    visualDensity: VisualDensity.compact),
                onPressed: () {
                  context.goNamed("/");
                  restartFunction();
                  hideBeaconResultOverlay();
                },
                child: const Icon(
                  Icons.replay_circle_filled_outlined,
                  color: Colors.white,
                ),
              ),
              // FilledButton(
              //   style: FilledButton.styleFrom(
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //       backgroundColor: primaryColor,
              //       visualDensity: VisualDensity.compact),
              //   onPressed: () {
              //     context.goNamed("");
              //     resetEddystoneStreamController();
              //     hideBeaconResultOverlay();
              //   },
              //   child: const Icon(
              //     Icons.close,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(),
  );

  Overlay.of(context).insert(_overlayEntry!);
}

void hideBeaconResultOverlay() {
  _overlayEntry?.remove();
  _overlayEntry = null;
}
