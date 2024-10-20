import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:events_jo/config/custom_icons_icons.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

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
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.list,
            size: 30,
            color: selecetedPage == 0 ? MyColors.red : MyColors.white,
          ),
          Icon(
            CustomIcons.eventsjo,
            size: 35,
            color: selecetedPage == 1 ? MyColors.red : MyColors.white,
          ),
          Icon(
            Icons.settings,
            size: 25,
            color: selecetedPage == 2 ? MyColors.red : MyColors.white,
          ),
        ],
        index: selecetedPage,
        onTap: (value) => setState(() {
          selecetedPage = value;
        }),
        color: MyColors.red,
        backgroundColor: MyColors.scaffoldBg,
        buttonBackgroundColor: MyColors.white,
      ),
      body: screens[selecetedPage],
    );
  }
}
