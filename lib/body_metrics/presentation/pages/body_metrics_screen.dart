import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/bloc/fetch_body_measurement_bloc/fetch_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
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
    fetchBodyMeasurement();
  }

  void fetchBodyMeasurement() {
    var stateMember = context.read<DetailMemberBloc>().state;
    if (stateMember is DetailMemberSuccess) {
      context
          .read<FetchBodyMeasurementBloc>()
          .add(DoFetchBodyMeasurement(stateMember.datas.memberCode));
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
                    BlocBuilder<FetchBodyMeasurementBloc, FetchBodyMeasurementState>(
                      builder: (context, state) {
                        return Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: () {
                              if (state is FetchBodyMeasurementSuccess) {
                                if (state.datas.isNotEmpty) {
                                  context.go("/body-measurements-tracker");
                                  return;
                                }
                              }
                              context.go("/register-body-measurements-tracker");
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Ink(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                              ),
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
                                    style:
                                        TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15),
                        child: Ink(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                          ),
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
                        ),
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
