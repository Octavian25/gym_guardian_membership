import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class DetailLevelScreen extends StatefulWidget {
  final String currentLevel;
  const DetailLevelScreen({super.key, required this.currentLevel});

  @override
  State<DetailLevelScreen> createState() => _DetailLevelScreenState();
}

class _DetailLevelScreenState extends State<DetailLevelScreen> {
  ScrollController scrollController = ScrollController();

  String getQuote(String level) {
    switch (level) {
      case 'beginner':
        return beginnerMessage[randomNumber(2, 0)];
      case 'intermediate':
        return intermediateMessage[randomNumber(2, 0)];
      case 'enthusiast':
        return anthusiastMessage[randomNumber(2, 0)];
      default:
        return beginnerMessage[randomNumber(2, 0)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/background_home.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                forceMaterialTransparency: true,
              ),
              SliverToBoxAdapter(
                child: Hero(
                        tag: "level_icon",
                        child: Image.asset(
                          "assets/${widget.currentLevel}.png",
                          height: 120,
                        ))
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true, period: 3.seconds),
                    )
                    .shimmer(),
              ),
              SliverToBoxAdapter(child: 10.verticalSpacingRadius),
              SliverToBoxAdapter(
                  child: Center(
                child: Text("Level Saat Ini"),
              ).animate().slideY(begin: -0.3, end: 0)),
              SliverToBoxAdapter(
                  child: Center(
                child: Text(
                  widget.currentLevel,
                  style: bebasNeue.copyWith(fontSize: 35.spMin),
                ),
              ).animate().slideY(begin: 0.3, end: 0)),
              SliverToBoxAdapter(child: 10.verticalSpacingRadius),
              baseSliverPadding(
                sliver: SliverToBoxAdapter(
                    child: Center(
                  child: Text(
                    intermediateMessage[randomNumber(2, 0)],
                    textAlign: TextAlign.center,
                  ),
                ).animate().fadeIn()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
