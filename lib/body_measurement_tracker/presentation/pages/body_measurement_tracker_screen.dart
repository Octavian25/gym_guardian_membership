import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/bloc/fetch_body_measurement_bloc/fetch_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/widgets/bmi_card_widget.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/widgets/circumference_widget.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/widgets/update_measurement_widget.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/pages/pricing_plan_screen.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart' hide TextDirection;

class BodyMeasurementTracker extends StatefulWidget {
  const BodyMeasurementTracker({super.key});

  @override
  State<BodyMeasurementTracker> createState() => _BodyMeasurementTrackerState();
}

class _BodyMeasurementTrackerState extends State<BodyMeasurementTracker> {
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> scrollNotifier = ValueNotifier<bool>(false);
  int selectedIndex = 0;
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
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var dataState = context.read<FetchBodyMeasurementBloc>().state;
        if (dataState is FetchBodyMeasurementSuccess) {
          setState(() {
            selectedIndex = dataState.datas.length - 1;
          });
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
          BlocConsumer<FetchBodyMeasurementBloc, FetchBodyMeasurementState>(
            listener: (context, state) {
              if (state is FetchBodyMeasurementSuccess) {
                setState(() {
                  selectedIndex = state.datas.length - 1;
                });
              }
            },
            builder: (context, state) {
              if (state is FetchBodyMeasurementSuccess) {
                BodyMeasurementEntity? lastData = state.datas[selectedIndex];
                return CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    ValueListenableBuilder(
                      valueListenable: scrollNotifier,
                      builder: (context, isScrolled, child) => SliverAppBar(
                        backgroundColor: Colors.white,
                        forceMaterialTransparency: isScrolled ? false : true,
                        floating: true,
                        pinned: true,
                        title: Text(
                          context.l10n.body_measure_tracker,
                          style: bebasNeue.copyWith(fontSize: 25.spMin),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        dense: true,
                        title: Center(
                            child: Text(formatDateWithTime(lastData.inputDate ?? DateTime.now()))),
                        titleAlignment: ListTileTitleAlignment.center,
                        leading: IconButton(
                            onPressed: selectedIndex == 0
                                ? null
                                : () {
                                    setState(() {
                                      selectedIndex--;
                                    });
                                  },
                            icon: Icon(Icons.chevron_left_rounded)),
                        trailing: IconButton(
                            onPressed: selectedIndex == state.datas.length - 1
                                ? null
                                : () {
                                    setState(() {
                                      selectedIndex++;
                                    });
                                  },
                            icon: Icon(Icons.chevron_right_rounded)),
                      ),
                    ),
                    SliverToBoxAdapter(child: 5.verticalSpacingRadius),
                    SliverToBoxAdapter(
                      child: UpdateMeasurementButton(
                        lastUpdate:
                            "${context.l10n.last_update_measurement} : ${formatDateWithTime(lastData.inputDate ?? DateTime.now())}",
                      ),
                    ),
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                    SliverToBoxAdapter(
                      child: CardBMIWidget(
                          listData: state.datas, lastData: lastData, selectedIndex: selectedIndex),
                    ),
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                    SliverToBoxAdapter(
                        child: CircumferenceCard(
                      title: context.l10n.chest_circumference,
                      type: "cm",
                      value: lastData.chestCircumference?.toDouble() ?? 0,
                    )),
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                    SliverToBoxAdapter(
                        child: CircumferenceCard(
                      title: context.l10n.waist_circumference,
                      type: "cm",
                      value: lastData.waistCircumference?.toDouble() ?? 0,
                    )),
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                    SliverToBoxAdapter(
                        child: CircumferenceCard(
                      title: context.l10n.thigh_circumference,
                      type: "cm",
                      value: lastData.thighCircumference?.toDouble() ?? 0,
                    )),
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                    SliverToBoxAdapter(
                        child: CircumferenceCard(
                      title: context.l10n.arm_circumference,
                      type: "cm",
                      value: lastData.armCircumference?.toDouble() ?? 0,
                    )),
                    SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                    SliverToBoxAdapter(
                        child: CircumferenceCard(
                      title: context.l10n.body_fat,
                      type: "%",
                      value: lastData.bodyFatPercentage?.toDouble() ?? 0,
                    )),
                    SliverToBoxAdapter(child: 20.verticalSpacingRadius),
                  ],
                );
              } else if (state is FetchBodyMeasurementFailure) {
                return ErrorBuilderWidget(
                  errorMessage: state.message,
                  handleReload: () {
                    context.pop();
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
