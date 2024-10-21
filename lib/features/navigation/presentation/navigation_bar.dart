import 'package:events_jo/config/custom_icons_icons.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selecetedPage = 1;

  final screens = [
    const Center(child: Text('List of the user orders')),
    const HomePage(),
    const Center(child: Text('Settings page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GNav(
            backgroundColor: MyColors.navBar,
            tabBorderRadius: 20,
            duration: const Duration(milliseconds: 300),
            color: MyColors.red,
            activeColor: MyColors.white,
            rippleColor: MyColors.white.withOpacity(0.2),
            iconSize: 24,
            tabBackgroundColor: MyColors.red,
            textStyle: TextStyle(
              fontSize: 17,
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            ),
            selectedIndex: selecetedPage,
            tabMargin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            tabs: const [
              GButton(
                icon: Icons.list,
                text: ' Your Orders',
              ),
              GButton(
                icon: CustomIcons.eventsjo,
                text: ' Home',
              ),
              GButton(
                icon: Icons.settings,
                text: ' Settings',
              ),
            ],
            onTabChange: (value) => setState(() => selecetedPage = value),
          ),
        ),
      ),
      body: screens[selecetedPage],
    );
  }
}
