import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';

class InformationDetail extends StatelessWidget {
  final String title;
  final String value;
  const InformationDetail({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 11.spMin),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.bold),
        ),
        10.verticalSpacingRadius,
      ],
    );
  }
}
