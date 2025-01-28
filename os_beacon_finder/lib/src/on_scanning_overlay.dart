import 'package:os_beacon_finder/src/init_scan_beacon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

OverlayEntry? _overlayEntry;

void showScanningOverlay(
    BuildContext context,
    String title,
    String subtitle,
    ButtonStyle? closeButtonStyle,
    Widget? closeButtonWidget,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle) {
  if (_overlayEntry != null) return; // Mencegah overlay duplikasi

  _overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: kToolbarHeight,
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
              SizedBox(
                width: 15.dg,
                height: 15.dg,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
              10.horizontalSpaceRadius,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    Text(
                      subtitle,
                      style: subtitleStyle ?? const TextStyle(fontSize: 9),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              FilledButton(
                style: closeButtonStyle ??
                    FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.white,
                        visualDensity: VisualDensity.compact),
                onPressed: () {
                  resetEddystoneStreamController();
                },
                child: closeButtonWidget ??
                    const Text(
                      "Tutup",
                      style: TextStyle(color: Colors.black),
                    ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(),
  );

  Overlay.of(context).insert(_overlayEntry!);
}

void hideScanningOverlay() {
  _overlayEntry?.remove();
  _overlayEntry = null;
}
