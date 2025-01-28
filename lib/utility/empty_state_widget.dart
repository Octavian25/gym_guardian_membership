import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const EmptyStateWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.verticalSpacingRadius,
        Center(
          child: Image.asset(
            "assets/emptyState.png",
            height: 0.2.sw,
            fit: BoxFit.cover,
          ),
        ),
        5.verticalSpacingRadius,
        SizedBox(
          width: 0.8.sw,
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.spMin),
            ),
          ),
        ),
        5.verticalSpacingRadius,
        SizedBox(
          width: 0.8.sw,
          child: Center(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.spMin),
            ),
          ),
        ),
        10.verticalSpacingRadius,
      ],
    );
  }
}
