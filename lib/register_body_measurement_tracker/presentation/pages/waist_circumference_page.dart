import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/presentation/bloc/body_measurement_bloc/body_measurement_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/ruler_picker_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class WaistCirfumferenceRegisterBodymeasurement extends StatefulWidget {
  const WaistCirfumferenceRegisterBodymeasurement({super.key});

  @override
  State<WaistCirfumferenceRegisterBodymeasurement> createState() =>
      _WaistCirfumferenceRegisterBodymeasurementState();
}

class _WaistCirfumferenceRegisterBodymeasurementState
    extends State<WaistCirfumferenceRegisterBodymeasurement> {
  ValueNotifier<int> waisttNotifier = ValueNotifier(50);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            20.verticalSpacingRadius,
            SizedBox(
              width: 0.7.sw,
              child: Text(
                context.l10n.hows_your_waist_circumference,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.bold),
              ),
            ),
            20.verticalSpacingRadius,
            Expanded(
              child: Stack(
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: waisttNotifier,
                    builder: (context, value, child) => Center(
                        child: Transform.translate(
                      offset: Offset(0, -(70.spMin / 2)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            value.toString(),
                            style: bebasNeue.copyWith(fontSize: 70.spMin, height: 0.9),
                          ),
                          Text(
                            "cm",
                            style: bebasNeue.copyWith(fontSize: 20.spMin),
                          ),
                        ],
                      ),
                    )),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            primaryColor,
                            primaryColor,
                            Colors.transparent
                          ],
                          stops: const [
                            0.0,
                            0.2,
                            0.8,
                            1.0
                          ]).createShader(bounds);
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) => SimpleRulerPicker(
                        axis: Axis.vertical,
                        selectedTextStyle: bebasNeue.copyWith(fontSize: 50.spMin),
                        initialValue: 50,
                        height: constraints.maxHeight,
                        maxValue: 300,
                        scaleItemWidth: 15,
                        showSelectedText: true,
                        showBottomText: false,
                        horizontalPointerWidth: constraints.maxWidth * 0.6,
                        onValueChanged: (value) {
                          waisttNotifier.value = value.ceil();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpacingRadius,
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: PrimaryButtonIcon(
                    color: onPrimaryColor,
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.go("/register-body-measurements-tracker/chest-circumference");
                    },
                  ),
                ),
                5.horizontalSpaceRadius,
                Flexible(
                  flex: 4,
                  child: PrimaryButton(
                    title: context.l10n.next,
                    onPressed: () {
                      var currentState = context.read<BodyMeasurementBloc>().state;
                      if (currentState is BodyMeasurementSuccess) {
                        context.read<BodyMeasurementBloc>().add(DoBodyMeasurement(
                            currentState.datas.copyWith(waistCircumference: waisttNotifier.value)));
                      }

                      context.go("/register-body-measurements-tracker/thigh-circumference");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
