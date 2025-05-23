import 'dart:math';

import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/config/utils/unique.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_drink_card.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_meal_card.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/event_added_successfully_page.dart';
import 'package:events_jo/features/owner/representation/components/creation/owner_page_navigation_bar.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_drinks_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_location_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_meals_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_name_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_event_type_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_images_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_license_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_people_range.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_range_date_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/sub%20pages/select_range_time_page.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_states.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

//* This page lets owners create an event
class OwnerEventCreationPage extends StatefulWidget {
  final AppUser? user;

  const OwnerEventCreationPage({
    super.key,
    required this.user,
  });

  @override
  State<OwnerEventCreationPage> createState() => _OwnerEventCreationPageState();
}

class _OwnerEventCreationPageState extends State<OwnerEventCreationPage> {
  late final AppUser user;

  //owner cubit instance
  late final OwnerCubit ownerCubit;

  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final EjLocation userLocation;

  //event name
  final TextEditingController nameController = TextEditingController();

  //venue, farm or court
  EventType eventType = EventType.venue;

  //event date and time
  DateTimeRange? range;
  List<int> time = [12, 12];

  //temp value for UI control
  int tempValueForTime = 0;

  //images list
  List<XFile> images = [];

  //license
  List<XFile> license = [];

  //people
  TextEditingController peopleMinController = TextEditingController();
  TextEditingController peopleMaxController = TextEditingController();
  TextEditingController peoplePriceController = TextEditingController();

  //meals
  List<WeddingVenueMeal> meals = [];
  TextEditingController mealNameController = TextEditingController();
  TextEditingController mealAmountController = TextEditingController();
  TextEditingController mealPriceController = TextEditingController();

  //meals
  List<WeddingVenueDrink> drinks = [];
  TextEditingController drinkNameController = TextEditingController();
  TextEditingController drinkAmountController = TextEditingController();
  TextEditingController drinkPriceController = TextEditingController();
  @override
  void initState() {
    super.initState();

    //get user
    user = widget.user!;

    //get cubits
    ownerCubit = context.read<OwnerCubit>();
    locationCubit = context.read<LocationCubit>();

    //setup user location values
    userLocation = EjLocation(
      lat: user.latitude,
      long: user.longitude,
      initLat: user.latitude,
      initLong: user.longitude,
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mealNameController.dispose();
    mealAmountController.dispose();
    mealPriceController.dispose();
    drinkNameController.dispose();
    drinkAmountController.dispose();
    drinkPriceController.dispose();
    peopleMinController.dispose();
    peopleMaxController.dispose();
    peoplePriceController.dispose();
    ownerCubit.emit(OwnerInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Add Events',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          //loads children only when needed
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  SelectEventType(
                    eventType: eventType,
                    onSelected: (event) => setState(() => eventType = event),
                  ),

                  //name
                  SelectEventNamePage(
                    eventType: eventType,
                    nameController: nameController,
                    testPress: () {
                      setState(() {
                        nameController.text =
                            'Test ${eventType.name.toCapitalized} ${Random().nextInt(900) + 100}';
                      });
                    },
                  ),

                  //location
                  SelectEventLocationPage(
                    eventType: eventType,
                    onPressed: () => locationCubit.showMapDialog(
                      context,
                      userLocation: userLocation,
                    ),
                  ),

                  //pics
                  SelectImagesPage(
                    images: images,
                    eventType: eventType,
                    onPressed: () async {
                      //pick images
                      final selectedImages =
                          await ImagePicker().pickMultiImage(limit: 6);

                      //user cancels -> save old list
                      if (selectedImages.isEmpty) return;

                      //user confirms -> clear old list and add new images
                      images.clear();
                      images.addAll(selectedImages);

                      //update
                      setState(() {});
                    },
                  ),

                  //license
                  SelectLicensePage(
                    images: license,
                    eventType: eventType,
                    onPressed: () async {
                      //pick images
                      final selectedLicense =
                          await ImagePicker().pickMultiImage(limit: 2);

                      //save old license
                      if (selectedLicense.isEmpty) return;

                      //save new license
                      license.clear();
                      license.add(selectedLicense.first);

                      //update
                      setState(() {});
                    },
                  ),

                  const Divider(),
                  //date range
                  SelectRangeDatePage(
                    eventType: eventType,
                    range: range,
                    onRangeSelected: (value) => setState(() => range = value),
                  ),

                  //time range
                  SelectRangeTimePage(
                    tempValueForTime: tempValueForTime,
                    time: time,
                    onTab: (from, to) => setState(
                      () {
                        //control UI
                        tempValueForTime = 1;

                        //set time
                        time[0] = from.hour;
                        time[1] = to.hour;
                      },
                    ),
                  ),

                  const Divider(),

                  if (eventType == EventType.court)
                    SelectPeopleRange(
                      eventType: eventType,
                      peoplePriceController: peoplePriceController,
                      peopleMinController: peopleMinController,
                      peopleMaxController: peopleMaxController,
                      testPress: () {
                        setState(() {
                          peoplePriceController.text = '15'; //Receive
                        });
                      },
                    ),

                  //people range
                  if (eventType == EventType.venue) ...[
                    SelectPeopleRange(
                      eventType: eventType,
                      peoplePriceController: peoplePriceController,
                      peopleMinController: peopleMinController,
                      peopleMaxController: peopleMaxController,
                      testPress: () {
                        setState(() {
                          peoplePriceController.text = '1.5';
                          peopleMaxController.text = '1000';
                          peopleMinController.text = '10';
                        });
                      },
                    ),

                    const Divider(),

                    //meals
                    SelectEventMealsPage(
                      eventType: eventType,
                      mealNameController: mealNameController,
                      mealAmountController: mealAmountController,
                      mealPriceController: mealPriceController,
                      meals: meals,
                      //update image when typing (only update state)
                      onTextFieldChanged: (text) => setState(() {}),
                      //update field on menu select
                      onMealSelected: (meal) => setState(() {
                        mealNameController.text = meal.toString();
                        mealAmountController.text =
                            (Random().nextInt(900) + 100).toString();
                        mealPriceController.text = '2.5';
                      }),
                      itemBuilder: (context, index) {
                        return OwnerMealCard(
                          meals: meals,
                          index: index,
                          onPressed: () =>
                              setState(() => meals.removeAt(index)),
                        );
                      },
                      onAddPressed: () {
                        //checks if fields are empty
                        if (mealNameController.text.isEmpty) {
                          context
                              .showSnackBar('Please add a name for the meal');
                          return;
                        }
                        if (mealAmountController.text.isEmpty) {
                          context.showSnackBar(
                              'Please add an amount for the meal');
                          return;
                        }
                        if (mealPriceController.text.isEmpty) {
                          context
                              .showSnackBar('Please add a price for the meal');
                          return;
                        }

                        //add meal to list
                        meals.add(
                          WeddingVenueMeal(
                            id: 'added later :D',
                            name: mealNameController.text.trim(),
                            amount: int.parse(mealAmountController.text),
                            price: double.parse(mealPriceController.text),
                          ),
                        );

                        //clear fields after addition
                        mealNameController.clear();
                        mealAmountController.clear();
                        mealPriceController.clear();

                        //update
                        setState(() {});
                      },
                    ),

                    //drinks
                    SelectEventDrinksPage(
                      eventType: eventType,
                      drinkNameController: drinkNameController,
                      drinkAmountController: drinkAmountController,
                      drinkPriceController: drinkPriceController,
                      drinks: drinks,
                      //update image when typing (only update state)
                      onChanged: (text) => setState(() {}),
                      //update field on menu select
                      onDrinkSelected: (drink) {
                        setState(() {
                          drinkNameController.text = drink.toString();
                          drinkAmountController.text =
                              (Random().nextInt(900) + 100).toString();
                          drinkPriceController.text = '2.5';
                        });
                      },
                      itemBuilder: (context, index) {
                        return OwnerDrinkCard(
                          drinks: drinks,
                          index: index,
                          onPressed: () =>
                              setState(() => drinks.removeAt(index)),
                        );
                      },
                      onAddPressed: () {
                        //checks if fields are empty
                        if (drinkNameController.text.isEmpty) {
                          context
                              .showSnackBar('Please add a name for the drink');
                          return;
                        }
                        if (drinkAmountController.text.isEmpty) {
                          context.showSnackBar(
                              'Please add an amount for the drink');
                          return;
                        }
                        if (drinkPriceController.text.isEmpty) {
                          context
                              .showSnackBar('Please add a price for the drink');
                          return;
                        }

                        //add meal to list
                        drinks.add(
                          WeddingVenueDrink(
                            id: 'added later :D',
                            name: drinkNameController.text.trim(),
                            amount: int.parse(drinkAmountController.text),
                            price: double.parse(drinkPriceController.text),
                          ),
                        );

                        //clear fields after addition
                        drinkNameController.clear();
                        drinkAmountController.clear();
                        drinkPriceController.clear();

                        //update
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),

      //watch the state here to hide the bar when loading
      bottomNavigationBar: OwnerPageNavigationBar(
        eventType: eventType,
        //this method checks user input and control current page
        onPressed: () => setState(
          () {
            //if no name provided

            if (nameController.text.isEmpty) {
              context.showSnackBar('Please enter a name');
              return;
            }

            if (license.isEmpty) {
              context.showSnackBar('Please provide a license');
              return;
            }

            //if no date range provided

            if (range == null) {
              context.showSnackBar('Please enter a range of date');
              return;
            }

            //if no time range provided

            if (tempValueForTime == 0) {
              context.showSnackBar('Please enter a range of time');
              return;
            }

            //checks if fields are empty
            if (peoplePriceController.text.isEmpty) {
              context.showSnackBar('Please add a price');
              return;
            }

            if (eventType == EventType.venue) {
              if (peopleMinController.text.isEmpty) {
                context.showSnackBar('Please add a minimum amount');
                return;
              }
            }

            if (eventType == EventType.venue) {
              if (peopleMaxController.text.isEmpty) {
                context.showSnackBar('Please add a maximum amount');
                return;
              }
            }

            //checks if valid range
            if (eventType == EventType.venue) {
              if (int.parse(peopleMinController.text) >=
                  int.parse(peopleMaxController.text)) {
                context.showSnackBar('Please add a valid range of people');
                return;
              }
            }

            //everything in check
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              // isDismissible: false,
              builder: (context) => BlocConsumer<OwnerCubit, OwnerStates>(
                listener: (context, state) {
                  if (state is OwnerError) {
                    context.showSnackBar(state.message);
                  }
                },
                builder: (context, state) {
                  //done
                  if (state is OwnerLoaded) {
                    return EventAddedSuccessfullyPage(
                      eventType: eventType,
                      onPressed: () {
                        context.pop();
                        context.pop();
                      },
                    );
                  }

                  //error
                  if (state is OwnerError) {
                    return EventAddedSuccessfullyPage(
                      text: 'There was an error, please try again',
                      eventType: eventType,
                      onPressed: () {
                        context.pop();
                        context.pop();
                      },
                    );
                  }
                  //loading
                  if (state is OwnerLoading) {
                    return const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GlobalLoadingBar(mainText: false),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: GColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kOuterRadius),
                        topRight: Radius.circular(kOuterRadius),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 30,
                      children: [
                        const SizedBox(width: 100, child: Divider()),
                        Text(
                          'Are your sure to proceed with your ${eventType.name} ?',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kNormalFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: GColors.royalBlue,
                                  fontSize: kNormalFontSize,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                //reset urls for images
                                List<String> urls = [];
                                urls.clear();

                                //if user selected images
                                if (images.isNotEmpty) {
                                  urls = await ownerCubit.addImagesToServer(
                                      images, nameController.text);
                                }
                                if (eventType == EventType.venue) {
                                  //call cubit
                                  await ownerCubit.addVenueToDatabase(
                                    name: nameController.text.trim(),
                                    //TODO
                                    lat: userLocation.lat,
                                    long: userLocation.long,
                                    stripeAccountId: user.stripeAccountId!,
                                    peopleMax:
                                        int.parse(peopleMaxController.text),
                                    peopleMin:
                                        int.parse(peopleMinController.text),
                                    peoplePrice: double.parse(
                                        peoplePriceController.text),
                                    pics: images.isNotEmpty ? urls : null,
                                    meals: meals.isNotEmpty ? meals : null,
                                    drinks: drinks.isNotEmpty ? drinks : null,
                                    startDate: [
                                      range!.start.year,
                                      range!.start.month,
                                      range!.start.day,
                                    ],
                                    endDate: [
                                      range!.end.year,
                                      range!.end.month,
                                      range!.end.day,
                                    ],
                                    time: [
                                      time[0],
                                      time[1],
                                    ],
                                    ownerId: user.uid,
                                    ownerName: user.name,
                                  );
                                }
                                if (eventType == EventType.court) {
                                  await ownerCubit.addCourtToDatabase(
                                    FootballCourt(
                                      id: Unique.generateUniqueId(),
                                      name: nameController.text.trim(),
                                      stripeAccountId: user.stripeAccountId!,
                                      latitude: userLocation.lat,
                                      longitude: userLocation.long,
                                      pricePerHour: double.parse(
                                          peoplePriceController.text),
                                      pics: images.isNotEmpty ? urls : [],
                                      rates: [],
                                      isApproved: false,
                                      isBeingApproved: false,
                                      ownerId: user.uid,
                                      ownerName: user.name,
                                      startDate: [
                                        range!.start.year,
                                        range!.start.month,
                                        range!.start.day,
                                      ],
                                      endDate: [
                                        range!.end.year,
                                        range!.end.month,
                                        range!.end.day,
                                      ],
                                      time: [
                                        time[0],
                                        time[1],
                                      ],
                                      city: await ownerCubit.getCity(
                                              userLocation.lat,
                                              userLocation.long) ??
                                          '  ',
                                    ),
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    GColors.whiteShade3.shade600),
                              ),
                              icon: Text(
                                'Proceed',
                                style: TextStyle(
                                  color: GColors.royalBlue,
                                  fontSize: kNormalFontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
