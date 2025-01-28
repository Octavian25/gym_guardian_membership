import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/splashscreen/data/models/splash_model.dart';
import 'package:gym_guardian_membership/utility/constant.dart';

class SplashContent extends StatelessWidget {
  final SplashData data;
  final TabController tabController;
  final int activeIndex;
  const SplashContent(
      {super.key, required this.data, required this.tabController, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: Image.asset(
            data.illustration,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: data.title),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const Spacer(),
        if (data.showButton)
          SizedBox(
            height: 50,
            width: 180,
            child: FilledButton(
              onPressed: () {
                tabController.animateTo(tabController.index + 1);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black),
              ),
              child: Text(
                "Ayo Mulai",
                style: bebasNeue.copyWith(fontSize: 20),
              ),
            ),
          ),
        const Spacer(),
      ],
    );
  }
}
