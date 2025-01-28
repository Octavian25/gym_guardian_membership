import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
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
                      color: Colors.white,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                    ),
                    label: "Profile")
              ]),
        ));
  }
}
