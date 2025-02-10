import 'package:flutter/material.dart';

import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/preview_registration_bloc/preview_registration_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/domain/entities/pricing_plan_entity.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/bloc/fetch_all_pricing_plan_bloc/fetch_all_pricing_plan_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class PricingPlanScreen extends StatefulWidget {
  const PricingPlanScreen({super.key});

  @override
  State<PricingPlanScreen> createState() => _PricingPlanScreenState();
}

class _PricingPlanScreenState extends State<PricingPlanScreen> {
  ScrollController scrollController = ScrollController();
  PricingPlanEntity? selectedPlan;

  void handlePreviewAccount() async {
    if (selectedPlan == null) {
      showError(context.l10n.your_not_select_plan, context);
      return;
    }
    PreviewRegistrationEntity? previewRegistrationEntity;
    var previewState = context.read<PreviewRegistrationBloc>().state;
    if (previewState is PreviewRegistrationHasData) {
      previewRegistrationEntity = previewState.previewRegistrationEntity;
    }
    if (previewRegistrationEntity == null) {
      showError(context.l10n.your_skip_fill_data, context);
      return;
    }
    previewRegistrationEntity.setPricingPlan(selectedPlan!);
    context
        .read<PreviewRegistrationBloc>()
        .add(DoSavePreviewRegistration(previewRegistrationEntity));
    context.go("/login/register/pricing/preview");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(),
        SliverToBoxAdapter(child: 16.verticalSpacingRadius),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.l10n.pricing_plan_title,
              style: bebasNeue.copyWith(fontSize: 30.spMin),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.l10n.pricing_plan_subtitle,
            ),
          ),
        ),
        SliverToBoxAdapter(child: 24.verticalSpacingRadius),
        BlocBuilder<FetchAllPricingPlanBloc, FetchAllPricingPlanState>(
          builder: (context, state) {
            if (state.isError) {
              return SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: ErrorBuilderWidget(
                  errorMessage: state.errorMessage,
                  handleReload: () {
                    context.read<FetchAllPricingPlanBloc>().add(DoFetchAllPricingPlan());
                  },
                ),
              ));
            }
            return SliverList.separated(
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  thickness: 0.5,
                ),
              ),
              itemCount: state.datas.length,
              itemBuilder: (context, index) {
                PricingPlanEntity planEntity = state.datas[index];
                return ListTile(
                  onTap: () {
                    setState(() {
                      selectedPlan = planEntity;
                    });
                  },
                  splashColor: primaryColor.withValues(alpha: 0.1),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    planEntity.packageName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      Text("${context.l10n.duration} : ${planEntity.duration} ${context.l10n.day}"),
                  leading: selectedPlan == planEntity
                      ? Icon(
                          Icons.check_circle,
                          color: primaryColor,
                        )
                      : null,
                  trailing: Container(
                      decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        formatRupiah(planEntity.price.toDouble()),
                        style: bebasNeue.copyWith(fontSize: 20.spMin),
                      )),
                );
              },
            );
          },
        ),
        SliverToBoxAdapter(child: 5.verticalSpacingRadius),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: PrimaryButton(
              title: context.l10n.preview_account,
              onPressed: handlePreviewAccount,
            ),
          ),
        ),
        SliverToBoxAdapter(child: 30.verticalSpacingRadius),
      ],
    ));
  }
}

class ErrorBuilderWidget extends StatelessWidget {
  final String errorMessage;
  final Function() handleReload;
  const ErrorBuilderWidget({super.key, required this.errorMessage, required this.handleReload});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpacingRadius,
            Image.asset(
              "assets/error.png",
              width: constraints.maxWidth * 0.2,
            ),
            SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.spMin, color: Colors.black54),
              ),
            ),
            5.verticalSpacingRadius,
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact, backgroundColor: Colors.blueGrey),
                onPressed: handleReload,
                icon: Icon(Icons.replay),
                label: Text(context.l10n.reload)),
            5.verticalSpacingRadius,
          ],
        );
      },
    );
  }
}
