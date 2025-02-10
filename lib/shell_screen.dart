import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/jimi_menu_widget.dart';
import 'package:gym_guardian_membership/utility/router.dart';
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: const Color.fromARGB(31, 97, 97, 97), blurRadius: 10, spreadRadius: 2)
          ]),
          child: NavigationBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 5,
              indicatorColor: primaryColor,
              surfaceTintColor: Colors.white,
              height: 55.h,
              selectedIndex: widget.activeIndex,
              onDestinationSelected: (value) {
                switch (value) {
                  case 0:
                    context.go("/homepage");
                    break;
                  case 1:
                    context.go("/gym-schedule");
                    break;
                  case 2:
                    context.go("/workout-assistance");
                    break;
                  case 3:
                    context.go("/body-measurements-tracker");
                    break;
                  case 4:
                    context.go("/profile");
                    break;
                  default:
                }
              },
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined, color: Colors.black54),
                    selectedIcon: Icon(
                      Icons.home_rounded,
                      color: onPrimaryColor,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.event_note, color: Colors.black54),
                    selectedIcon: Icon(
                      Icons.event_note,
                      color: onPrimaryColor,
                    ),
                    label: "Calendar"),
                NavigationDestination(
                    icon: Icon(Icons.smart_toy_outlined, color: Colors.black54),
                    selectedIcon: Icon(
                      Icons.smart_toy,
                      color: onPrimaryColor,
                    ),
                    label: "JIVA"),
                NavigationDestination(
                    icon: Icon(Icons.show_chart, color: Colors.black54),
                    selectedIcon: Icon(
                      Icons.show_chart,
                      color: onPrimaryColor,
                    ),
                    label: "Body"),
                NavigationDestination(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.black54,
                    ),
                    selectedIcon: Icon(
                      Icons.person_rounded,
                      color: onPrimaryColor,
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
