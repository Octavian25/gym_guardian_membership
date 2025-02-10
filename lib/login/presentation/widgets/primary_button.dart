import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color? color; // Add this line to accept a color parameter

  const PrimaryButton({super.key, required this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 1.sw,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return primaryColor;
            },
          ), // Use the color parameter
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: bebasNeue.copyWith(color: Colors.white, fontSize: 20.spMin),
        ),
      ),
    );
  }
}

class PrimaryButtonIcon extends StatelessWidget {
  final Icon icon;
  final Function()? onPressed;
  final Color? color; // Add this line to accept a color parameter

  const PrimaryButtonIcon({super.key, required this.icon, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 1.sw,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(color ?? primaryColor), // Use the color parameter
        ),
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}
