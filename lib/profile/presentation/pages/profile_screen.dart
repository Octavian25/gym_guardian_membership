import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';

import 'package:gym_guardian_membership/profile/presentation/widgets/edit_profile_widget.dart';
import 'package:gym_guardian_membership/profile/presentation/widgets/logout_confirmation_widget.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/locale_provider.dart';
import 'package:gym_guardian_membership/utility/notification_handler.dart';

import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController = ScrollController();
  final NotificationHandler notificationHandler = NotificationHandler();
  bool isNotificationGranted = false;
  int currentLanguage = 0;
  @override
  void initState() {
    super.initState();
    checkNotificationGranted();
    getCurrentLocale();
  }

  void getCurrentLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    currentLanguage = pref.getInt("LANG") ?? 0;
    if (currentLanguage == 0) {}
    setState(() {});
  }

  Future<void> checkNotificationGranted() async {
    NotificationsEnabledOptions? result = await notificationHandler.checkPermissionStatusIOS();
    setState(() {
      isNotificationGranted = result?.isEnabled ?? false;
    });
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
          BlocBuilder<DetailMemberBloc, DetailMemberState>(
            builder: (context, state) {
              if (state is DetailMemberSuccess) {
                return SafeArea(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverAppBar(
                        forceMaterialTransparency: true,
                        title: Text(context.l10n.profile),
                        centerTitle: true,
                        actions: [
                          IconButton(
                              onPressed: () {
                                showBlurredBottomSheet(
                                  context: parentKey.currentContext!,
                                  builder: (context) => BlurContainerWrapper(
                                      child: EditProfileWidget(
                                    memberEntity: state.datas,
                                  )),
                                );
                              },
                              icon: Icon(Icons.edit_outlined)),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Hero(
                                tag: "level_icon",
                                child: Image.asset(
                                  "assets/${state.datas.level}.png",
                                  height: 120,
                                ))
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true, period: 3.seconds),
                            )
                            .shimmer(),
                      ),
                      SliverToBoxAdapter(child: 10.verticalSpacingRadius),
                      SliverToBoxAdapter(
                          child: Center(
                        child: Text(
                          state.datas.memberName,
                          style: bebasNeue.copyWith(fontSize: 35.spMin),
                        ),
                      ).animate().slideY(begin: -0.5, end: 0)),
                      SliverToBoxAdapter(
                          child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${state.datas.level} member"),
                          ],
                        ),
                      ).animate().slideY(begin: 0.5, end: 0)),
                      SliverToBoxAdapter(child: 15.verticalSpacingRadius),
                      baseSliverPadding(
                          sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  context.l10n.subscription_info_title,
                                  style: bebasNeue.copyWith(fontSize: 20.spMin),
                                ),
                                Text(
                                  context.l10n.subscription_info_subtitle,
                                  style: TextStyle(fontSize: 11.spMin),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                      SliverToBoxAdapter(child: 5.verticalSpacingRadius),
                      baseSliverPadding(
                          sliver: SliverToBoxAdapter(
                              child: Divider(
                        thickness: 0.5,
                      ))),
                      baseSliverPadding(
                        sliver: SliverToBoxAdapter(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                context.l10n.plan_name,
                                style: TextStyle(fontSize: 11.spMin),
                              ),
                              subtitle: Text(
                                state.datas.packageName,
                                style: bebasNeue.copyWith(fontSize: 18.spMin),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                context.l10n.payment_status,
                                style: TextStyle(fontSize: 11.spMin),
                              ),
                              subtitle: Text(
                                state.datas.status ? context.l10n.paid : context.l10n.not_paid,
                                style: bebasNeue.copyWith(fontSize: 18.spMin),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                context.l10n.plan_expired,
                                style: TextStyle(fontSize: 11.spMin),
                              ),
                              subtitle: Text(
                                state.datas.expiredDate,
                                style: bebasNeue.copyWith(fontSize: 18.spMin),
                              ),
                            ),
                          ].animate(interval: 100.milliseconds).slideX(begin: 0.1, end: 0).fadeIn(),
                        )),
                      ),
                      baseSliverPadding(
                          sliver: SliverToBoxAdapter(
                        child: ListTile(
                          onTap: () {
                            final NotificationHandler notificationHandler = NotificationHandler();
                            notificationHandler.requestPermissions();
                          },
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            context.l10n.allow_notification,
                          ),
                          trailing: Switch(
                            padding: EdgeInsets.all(0),
                            value: isNotificationGranted,
                            onChanged: (value) {
                              if (value) {
                                notificationHandler.requestPermissions();
                              }
                            },
                          ),
                        ),
                      )),
                      // baseSliverPadding(
                      //     sliver: SliverToBoxAdapter(
                      //   child: ListTile(
                      //     onTap: () {
                      //       final NotificationHandler notificationHandler = NotificationHandler();
                      //       notificationHandler.showNotification(
                      //           "Gym Guardian Alert", "Jangan lupa latihan hari ini! 💪🔥",
                      //           payload: "gym_schedule");
                      //     },
                      //     contentPadding: EdgeInsets.zero,
                      //     dense: true,
                      //     leading: Icon(Icons.notification_add_rounded),
                      //     title: Text(
                      //       "Test Notifikasi",
                      //     ),
                      //   ),
                      // )),
                      baseSliverPadding(
                          sliver: SliverToBoxAdapter(
                        child: ListTile(
                          onTap: () {
                            showBlurredBottomSheet(
                              context: context,
                              builder: (context) => BlurContainerWrapper(
                                  child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${context.l10n.updated} ${context.l10n.language}",
                                      style: TextStyle(
                                          fontSize: 20.spMin, fontWeight: FontWeight.bold),
                                    ),
                                    5.verticalSpacingRadius,
                                    SizedBox(
                                      height: 150.h, // Adjust height as needed
                                      child: CupertinoPicker(
                                        itemExtent: 30.h, // Adjust item height as needed
                                        onSelectedItemChanged: (int index) async {
                                          currentLanguage = index;
                                          setState(() {});
                                        },
                                        magnification: 1.2,
                                        scrollController: FixedExtentScrollController(
                                            initialItem: currentLanguage),
                                        children: [
                                          Center(
                                              child: Text(
                                            'System Settings',
                                          )),
                                          Center(
                                              child: Text(
                                            'English',
                                          )),
                                          Center(
                                              child: Text(
                                            'Indonesia',
                                          ))
                                        ],
                                      ),
                                    ),
                                    PrimaryButton(
                                      title: "Pilih",
                                      onPressed: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences.getInstance();
                                        final localeProvider =
                                            Provider.of<LocaleProvider>(context, listen: false);
                                        localeProvider
                                            .setLocale(Locale(getLocaleCode(currentLanguage)));
                                        pref.setInt("LANG", currentLanguage);
                                        showSuccessWithoutButton(
                                            context.l10n.change_language_dialog, context);
                                        context.pop();
                                      },
                                    )
                                  ],
                                ),
                              )),
                            );
                          },
                          trailing: Text(
                            getLocaleName(currentLanguage),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.spMin),
                          ),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: Icon(Icons.language),
                          title: Text(
                            context.l10n.language,
                          ),
                        ),
                      )),
                      baseSliverPadding(
                          sliver: SliverToBoxAdapter(
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => LogoutConfirmationWidget(),
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: Icon(Icons.logout_rounded),
                          title: Text(
                            context.l10n.exit,
                          ),
                          trailing: Text(
                            "${context.l10n.version} 1.0.0",
                            style: TextStyle(fontSize: 10.spMin),
                          ),
                        ),
                      )),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

String getLocaleCode(int index) {
  switch (index) {
    case 1:
      return "en";
    case 2:
      return "id";
    default:
      return "en";
  }
}

String getLocaleName(int index) {
  switch (index) {
    case 0:
      return "System";
    case 1:
      return "English";
    case 2:
      return "Indonesia";
    default:
      return "en";
  }
}
