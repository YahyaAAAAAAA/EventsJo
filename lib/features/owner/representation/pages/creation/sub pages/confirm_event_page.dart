import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_button.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_confirmation_display_row.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_page_bar.dart';
import 'package:flutter/material.dart';

//* This page displays info for the user's event
class ConfirmEventPage extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? showMeals;
  final void Function()? showDrinks;
  final void Function()? showMap;
  final void Function()? showImages;
  final void Function()? showLicense;
  final EventType eventType;
  final String name;
  final DateTimeRange? range;
  final List<int> time;
  final double peoplePrice;
  final int peopleMax;
  final int peopleMin;

  const ConfirmEventPage({
    super.key,
    required this.onPressed,
    required this.eventType,
    required this.name,
    required this.range,
    required this.time,
    required this.peopleMax,
    required this.peopleMin,
    required this.peoplePrice,
    this.showMap,
    this.showImages,
    this.showMeals,
    this.showDrinks,
    this.showLicense,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView(
          children: [
            const OwnerPageBar(),

            //add to db
            OwnerButton(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              icon: Icons.done,
              iconSize: 50,
              padding: 8,
              text: eventType == EventType.venue
                  ? 'Add Your Wedding Venue To EventsJo'
                  : eventType == EventType.farm
                      ? 'Add Your Farm To EventsJo'
                      : 'Add Your Football Court To EventsJo',
              onPressed: onPressed,
            ),

            const SizedBox(height: 10),

            //confirm your information
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  eventType == EventType.venue
                      ? 'Please confirm your Wedding Venue information'
                      : eventType == EventType.farm
                          ? 'Please confirm your Farm information'
                          : 'Please confirm your Football Court information',
                  style: TextStyle(
                    color: GColors.poloBlue,
                  ),
                ),
              ),
            ),
            //summary list
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: GColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: GColors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //type
                  OwnerConfirmationDisplayRow(
                    mainText: 'Type: ',
                    subText: eventType == EventType.venue
                        ? 'Wedding Venue'
                        : eventType == EventType.farm
                            ? 'Farm'
                            : 'Football Court',
                  ),

                  localDivider(),

                  //name
                  OwnerConfirmationDisplayRow(
                      mainText: 'Name: ', subText: name),

                  localDivider(),

                  //date
                  OwnerConfirmationDisplayRow(
                      mainText: 'Date: ',
                      subText:
                          'From ${range!.start.month}/${range!.start.day}/${range!.start.year} - To ${range!.end.month}/${range!.end.day}/${range!.end.year}'),

                  localDivider(),

                  //time
                  OwnerConfirmationDisplayRow(
                      mainText: 'Open Hours: ',
                      subText:
                          'From ${time[0].toString().toTime} To ${time[1].toString().toTime}'),

                  localDivider(),

                  //people
                  OwnerConfirmationDisplayRow(
                      mainText: 'People Range: ',
                      subText:
                          'Between ${peopleMin.toString()} Person To ${peopleMax.toString()}'),

                  localDivider(),

                  //people
                  OwnerConfirmationDisplayRow(
                    mainText: 'Price Per Person: ',
                    subText: '${peoplePrice.toString()}JD',
                  ),

                  localDivider(),

                  //images
                  OwnerConfirmationDisplayRow(
                    mainText: 'Meals & Drinks: ',
                    isText: false,
                    subText: '',
                    icon: Icons.cake_rounded,
                    withSecondIcon: true,
                    secondIcon: Icons.free_breakfast,
                    onPressed: showMeals,
                    onPressedSecondIcon: showDrinks,
                  ),

                  localDivider(),

                  //images
                  OwnerConfirmationDisplayRow(
                    mainText: 'Images:    ',
                    isText: false,
                    subText: '',
                    icon: Icons.image,
                    onPressed: showImages,
                  ),

                  localDivider(),

                  //images
                  OwnerConfirmationDisplayRow(
                    mainText: 'License:   ',
                    isText: false,
                    subText: '',
                    icon: CustomIcons.license,
                    onPressed: showLicense,
                  ),

                  localDivider(),

                  //location
                  OwnerConfirmationDisplayRow(
                    mainText: 'Location:  ',
                    isText: false,
                    subText: '',
                    onPressed: showMap,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Divider localDivider() {
    return Divider(
      color: GColors.poloBlue,
      height: 0.01,
      thickness: 0.2,
      indent: 10,
      endIndent: 10,
    );
  }
}
