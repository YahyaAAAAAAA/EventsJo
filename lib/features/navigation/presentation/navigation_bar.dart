import 'package:events_jo/config/custom_icons_icons.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/config/my_progress_indicator.dart';
import 'package:events_jo/features/home/presentation/pages/home_page.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/location/representation/cubits/location_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selecetedPage = 1;

  final screens = [
    Center(
      child: Text(
        'List of the user orders',
        style: TextStyle(
          color: MyColors.black,
        ),
      ),
    ),
    const HomePage(),
    Center(
      child: Text(
        'Settings page',
        style: TextStyle(
          color: MyColors.black,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();

    //get user location
    context.read<LocationCubit>().getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 15,
        ),
        child: BlocConsumer<LocationCubit, LocationStates>(
          builder: (context, state) {
            //done
            if (state is LocationLoaded) {
              return ClipRRect(
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
              );
            }
            //loading or error
            else {
              return const SizedBox();
            }
          },
          listener: (context, state) {
            return;
          },
        ),
      ),
      body: BlocConsumer<LocationCubit, LocationStates>(
        builder: (context, state) {
          //error
          if (state is LocationError) {
            return Center(
              child: Text(
                'Error getting your location',
                style: TextStyle(
                  color: MyColors.black,
                ),
              ),
            );
          }

          //wait for location
          if (state is LocationLoaded) {
            return screens[selecetedPage];
          }
          //loading...
          else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Getting your location, please wait...',
                      style: TextStyle(
                        color: MyColors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MyProgressIndicator(color: MyColors.black),
                  ],
                ),
              ),
            );
          }
        },
        listener: (context, state) {
          //error
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
