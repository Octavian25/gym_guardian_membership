import 'package:flutter/material.dart';

class BodyMeasturementTracker extends StatefulWidget {
  const BodyMeasturementTracker({super.key});

  @override
  State<BodyMeasturementTracker> createState() => _BodyMeasturementTrackerState();
}

class _BodyMeasturementTrackerState extends State<BodyMeasturementTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Column(
          children: [Text("BODY MEASUREMENT")],
        ),
      ),
    );
  }
}
