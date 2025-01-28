import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';

SliverPadding baseSliverPadding({required Widget sliver}) {
  return SliverPadding(
    padding: baseHorizontalPadding,
    sliver: sliver,
  );
}
