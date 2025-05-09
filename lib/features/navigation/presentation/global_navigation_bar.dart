import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/pages/home_page.dart';
import 'package:events_jo/features/order/representation/pages/orders_page.dart';
import 'package:events_jo/features/settings/representation/pages/settings_page.dart';
import 'package:flutter/material.dart';

class GlobalNavigationBar extends StatefulWidget {
  final UserType userType;

  const GlobalNavigationBar({
    super.key,
    required this.userType,
  });

  @override
  State<GlobalNavigationBar> createState() => _GlobalNavigationBarState();
}

class _GlobalNavigationBarState extends State<GlobalNavigationBar> {
  int selectedPage = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      HomePage(userType: widget.userType),
      OrdersPage(userType: widget.userType),
      SettingsPage(userType: widget.userType),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: NavigationBar(
        backgroundColor: GColors.navBar,
        selectedIndex: selectedPage,
        animationDuration: const Duration(milliseconds: 300),
        indicatorColor: GColors.royalBlue.withValues(alpha: 0),
        indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kOuterRadius)),
        labelTextStyle: WidgetStatePropertyAll(TextStyle(
          color: GColors.black,
          fontFamily: 'Abel',
        )),
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.home,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.home,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              CustomIcons.list,
              color: GColors.royalBlue,
            ),
            icon: const Icon(
              CustomIcons.list,
            ),
            label: 'Bookings',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person_rounded,
              color: GColors.royalBlue,
              size: kNormalIconSize + 5,
            ),
            icon: const Icon(
              Icons.person_rounded,
              size: kNormalIconSize + 5,
            ),
            label: 'Account',
          ),
        ],
        onDestinationSelected: (value) {
          setState(() => selectedPage = value);
        },
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: screens[selectedPage],
      ),
    );
  }
}
