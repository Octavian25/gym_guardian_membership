import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/detail_member_bloc/detail_member_bloc.dart';

import 'package:gym_guardian_membership/profile/presentation/widgets/edit_profile_widget.dart';
import 'package:gym_guardian_membership/profile/presentation/widgets/logout_confirmation_widget.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';

import 'package:gym_guardian_membership/utility/router.dart';
import 'package:os_basecode/os_basecode.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController = ScrollController();
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
                        title: Text("Profile"),
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
                      SliverToBoxAdapter(child: 10.verticalSpacingRadius),
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
                                  "Informasi Berlangganan",
                                  style: bebasNeue.copyWith(fontSize: 20.spMin),
                                ),
                                Text(
                                  "Informasi Data Berlangganan Anda",
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
                                "Nama Paket",
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
                                "Status Pembayaran",
                                style: TextStyle(fontSize: 11.spMin),
                              ),
                              subtitle: Text(
                                state.datas.status ? "Dibayar" : "Belum Dibayar",
                                style: bebasNeue.copyWith(fontSize: 18.spMin),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                "Tanggal Berakhir",
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
                            showDialog(
                              context: context,
                              builder: (dialogContext) => LogoutConfirmationWidget(),
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: Icon(Icons.logout_rounded),
                          title: Text(
                            "Keluar",
                          ),
                          trailing: Text(
                            "Versi 1.0.0",
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
