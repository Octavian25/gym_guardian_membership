import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';

class ConnectWithGoogleButton extends StatelessWidget {
  final Function()? onPressed;
  const ConnectWithGoogleButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 1.sw,
      child: FilledButton.icon(
          icon: Icon(
            Icons.golf_course,
            color: Colors.black,
          ),
          style: Theme.of(context).filledButtonTheme.style?.copyWith(
              foregroundColor: WidgetStatePropertyAll("#303841".toColor()),
              backgroundColor: WidgetStatePropertyAll("#F5F5F5".toColor()),
              side: WidgetStatePropertyAll(
                  BorderSide(color: '#696969'.toColor().withValues(alpha: 0.26)))),
          onPressed: onPressed,
          label: Text(
            "Connect with Google",
          )),
    );
  }
}
