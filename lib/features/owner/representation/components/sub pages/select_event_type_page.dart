import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

//* This page lets the user to pick the event type (NOT REQUIRED)
//default is a Wedding Venue if empty
class SelectEventType extends StatelessWidget {
  final void Function()? onTap1;
  final void Function()? onTap2;
  final void Function()? onTap3;

  const SelectEventType({
    super.key,
    required this.selectedEventType,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
  });

  final int selectedEventType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //logo icon
        GradientIcon(
          icon: CustomIcons.events_jo,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          size: 100,
        ),

        //logo text
        GradientText(
          'EventsJo for Owners',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: GColors.logoGradient,
          ),
          style: TextStyle(
            color: GColors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        Text(
          'Pick which type of event you would like to add',
          style: TextStyle(
            color: GColors.poloBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 25),

        //type display
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //note no need to use container (heavy widget) if only (color and border) is required
            //-instead use ColoredBox and ClipRRect
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: GColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      //type icon
                      Icon(
                        selectedEventType == 0
                            ? CustomIcons.wedding
                            : selectedEventType == 1
                                ? CustomIcons.farm
                                : CustomIcons.football,
                        color: GColors.royalBlue,
                      ),

                      const SizedBox(width: 15),

                      //type name
                      Text(
                        selectedEventType == 0
                            ? 'Wedding Venue'
                            : selectedEventType == 1
                                ? 'Farm'
                                : 'Football Court',
                        style: TextStyle(
                          color: GColors.royalBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 25),

            //types menu
            PopupMenuButton(
              icon: Icon(
                Icons.menu,
                size: 30,
                color: GColors.royalBlue,
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(GColors.white),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
              color: GColors.white,
              position: PopupMenuPosition.under,
              offset: const Offset(0, 20),
              constraints: const BoxConstraints.tightFor(width: 150),
              initialValue: 0,
              tooltip: '',
              popUpAnimationStyle: AnimationStyle(
                duration: const Duration(milliseconds: 200),
              ),
              padding: const EdgeInsets.all(15),
              itemBuilder: (BuildContext context) {
                return [
                  //menu items
                  PopupMenuItem(
                    onTap: onTap1,
                    child: Text(
                      'Wedding Venue',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onTap2,
                    child: Text(
                      'Farm',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onTap3,
                    child: Text(
                      'Football Court',
                      style: TextStyle(
                        color: GColors.royalBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),

        const Spacer(flex: 2),
      ],
    );
  }
}