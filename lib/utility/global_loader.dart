import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';

class GlobalLoader {
  static OverlayEntry? _currentOverlay;

  /// Menampilkan overlay loading
  static void show() {
    if (parentKey.currentContext == null) return;
    if (_currentOverlay != null) return; // Jangan tampilkan jika sudah ada overlay aktif

    final overlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Latar belakang semi-transparan
          Container(
            color: Colors.black.withValues(alpha: 0.5),
            alignment: Alignment.center, // Loader
          ),
          Center(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                hide();
              },
              child: Ink(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/loading.png",
                        width: 60,
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(reverse: true),
                          )
                          .scaleXY(begin: 1, end: 0.8, duration: 700.milliseconds),
                      Text("Loading...")
                    ],
                  )),
            ),
          ))
        ],
      ),
    );

    _currentOverlay = overlay;

    parentKey.currentState?.overlay?.insert(overlay);
  }

  /// Menghapus overlay loading
  static void hide() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
