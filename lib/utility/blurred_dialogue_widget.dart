import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';

Future<T?> showBlurredBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  bool hasBlur = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    elevation: 0,
    useSafeArea: true,
    enableDrag: enableDrag,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: hasBlur ? 3 : 0,
          sigmaY: hasBlur ? 3 : 0,
        ),
        child: builder(context),
      ),
    ),
  );
}

class BlurContainerWrapper extends StatelessWidget {
  const BlurContainerWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.verticalSpacingRadius,
            Center(
              child: Container(
                width: 0.08.sw,
                height: 4,
                decoration:
                    BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(100)),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
