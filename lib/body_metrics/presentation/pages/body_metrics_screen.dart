import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class BodyMetricsScreen extends StatefulWidget {
  const BodyMetricsScreen({super.key});

  @override
  State<BodyMetricsScreen> createState() => _BodyMetricsScreenState();
}

class _BodyMetricsScreenState extends State<BodyMetricsScreen> {
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> scrollNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels > 50) {
          scrollNotifier.value = true;
        } else {
          scrollNotifier.value = false;
        }
      },
    );
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
            slivers: [
              ValueListenableBuilder(
                valueListenable: scrollNotifier,
                builder: (context, isScrolled, child) => SliverAppBar(
                  backgroundColor: Colors.white,
                  forceMaterialTransparency: isScrolled ? false : true,
                  floating: true,
                  pinned: true,
                  title: Text(
                    "Body Metrics Screen",
                    style: TextStyle(
                        fontSize: 18.spMin, color: onPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        context.go("/homepage");
                      },
                      icon: Icon(Icons.chevron_left_rounded, color: onPrimaryColor)),
                ),
              ),
              SliverToBoxAdapter(child: 10.verticalSpacingRadius),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    InkWell(
                      onTap: () {
                        context.go("/body-metrics/register-body-measurements-tracker");
                      },
                      child: Ink(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  color: Colors.grey.withValues(alpha: 0.2))
                            ]),
                        child: Column(
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) => Image.asset(
                                "assets/body-measurement.png",
                                width: constraints.maxWidth * 0.6,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Body\nMeasurement",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 1,
                                color: Colors.grey.withValues(alpha: 0.2))
                          ]),
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) => Image.asset(
                              "assets/strenght.png",
                              width: constraints.maxWidth * 0.6,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Strength &\nEndurance",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
