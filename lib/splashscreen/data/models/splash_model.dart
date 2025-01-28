import 'package:flutter/material.dart';

class SplashData {
  final String background;
  final String illustration;
  final List<TextSpan> title;
  final String description;
  final bool showButton;

  SplashData(
      {required this.background,
      required this.illustration,
      required this.title,
      required this.description,
      required this.showButton});
}
