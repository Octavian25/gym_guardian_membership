import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/injector.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/jimi_menu_widget.dart';
import 'package:gym_guardian_membership/utility/router.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:os_basecode/os_basecode.dart';

class ShellScreen extends StatefulWidget {
  final Widget body;
  final int activeIndex;
  const ShellScreen({super.key, required this.body, required this.activeIndex});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.body,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences pref = locator<SharedPreferences>();
            bool isJimiRunning = pref.getBool("gymMateBoot") ?? false;
            if (isJimiRunning) {
              showJimiMenu();
            } else {
              showBottomConfirmationDialogueAlert(
                  imagePath: "assets/ai.png",
                  title: "Selamat Datang di Jimi \nAsisten Latihan Pintar Anda!",
                  subtitle:
                      "Jimi siap membantu Anda mencapai target kebugaran dengan rencana latihan yang dipersonalisasi. Dapatkan rekomendasi workout terbaik sesuai dengan kebutuhan dan jadwal Anda!",
                  handleConfirm: (context) {
                    pref.setBool("gymMateBoot", true);
                    context.pop();
                    showJimiMenu();
                  });
            }
          },
          enableFeedback: true,
          backgroundColor: primaryColor,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              "assets/ai_floating.png",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: const Color.fromARGB(31, 97, 97, 97), blurRadius: 10, spreadRadius: 2)
          ]),
          child: NavigationBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 5,
              indicatorColor: "#E7F8D0".toColor(),
              surfaceTintColor: Colors.white,
              height: 50.h,
              selectedIndex: widget.activeIndex,
              onDestinationSelected: (value) {
                switch (value) {
                  case 0:
                    context.go("/homepage");
                    break;
                  case 1:
                    context.go("/profile");
                    break;
                  default:
                }
              },
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(
                      Icons.home_rounded,
                      color: primaryColor,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(
                      Icons.person_rounded,
                      color: primaryColor,
                    ),
                    label: "Profile")
              ]),
        ));
  }
}

void showJimiMenu() {
  showBlurredBottomSheet(
    context: parentKey.currentContext!,
    builder: (context) => BlurContainerWrapper(child: JimiMenuWidget()),
  );
}
