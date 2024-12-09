import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/representation/components/change_user_type_row.dart';
import 'package:events_jo/features/auth/representation/components/choose_location_method.dart';
import 'package:events_jo/features/auth/representation/components/events_jo_logo_auth.dart';
import 'package:events_jo/features/location/representation/components/location_loading_dialog.dart';
import 'package:events_jo/features/location/representation/components/location_provided_button.dart';
import 'package:events_jo/features/auth/representation/components/auth_button.dart';
import 'package:events_jo/features/auth/representation/components/auth_text_field.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/location/representation/cubits/location_states.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

//* This page allows user to make a new account (user or owner) to EventsJo
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text fields
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  //location related
  late final LocationCubit locationCubit;
  late MapLocation userLocation;
  Position? location;

  //determine which account to create (user or owner)
  bool isOwner = false;

  @override
  void initState() {
    super.initState();

    //get location cubit
    locationCubit = context.read<LocationCubit>();

    //prepare user location object
    userLocation = MapLocation(
      lat: 0,
      long: 0,
      initLat: 0,
      initLong: 0,
      marker: Marker(
        point: const LatLng(0, 0),
        child: Icon(
          Icons.location_pin,
          color: GColors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    locationCubit.emit(LocationInitial());
  }

  //some checks then proceeds with user registration through cubit
  void register() {
    //prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;
    final String name = nameController.text;

    //cubit
    final authCubit = context.read<AuthCubit>();

    //location empty
    if (userLocation.lat == 0 || userLocation.long == 0) {
      GSnackBar.show(
        context: context,
        text: 'Please provide your location',
      );

      return;
    }

    if (email.isNotEmpty &&
        pw.isNotEmpty &&
        name.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (pw == confirmPw) {
        authCubit.regitser(name, email, pw, userLocation.lat, userLocation.long,
            isOwner ? UserType.owner : UserType.user, true //makes user online
            );
      } else {
        GSnackBar.show(
          context: context,
          text: 'Passwords dont match',
        );
      }
    } else {
      GSnackBar.show(
        context: context,
        text: 'Please enter both email and password',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Center(child: EventsJoLogoAuth()),

                  //welcome back message
                  Text(
                    "Create an account",
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ChangeUserTypeRow(
                    setUserType: () => setState(() => isOwner = false),
                    setOwnerType: () => setState(() => isOwner = true),
                    isOwner: isOwner,
                  ),

                  const SizedBox(height: 10),

                  //name textField
                  AuthTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //email textField
                  AuthTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  //pw textField
                  AuthTextField(
                    controller: pwController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  AuthTextField(
                    controller: confirmPwController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  //location bloc
                  BlocConsumer<LocationCubit, LocationStates>(
                    builder: (context, state) {
                      //location not provided
                      if (state is LocationInitial || state is LocationError) {
                        return AuthButton(
                          onTap: () async => showDialog(
                            context: context,
                            builder: (context) {
                              return ChooseLocationMethod(
                                //pick location manually
                                onPressedManual: () async =>
                                    await locationCubit.showMapDialog(
                                  context,
                                  userLocation: userLocation,
                                  //used only here, to emit the state
                                  isOnce: true,
                                ),
                                //pick location automatically
                                onPressedAuto: () async {
                                  //pop the current dialog
                                  Navigator.of(context).pop();

                                  location =
                                      await locationCubit.getUserLocation();

                                  if (location == null) {
                                    return;
                                  }

                                  //save location
                                  userLocation.lat = location!.latitude;
                                  userLocation.long = location!.longitude;

                                  //save initial location
                                  userLocation.initLat = location!.latitude;
                                  userLocation.initLong = location!.longitude;

                                  //set marker to user location
                                  userLocation.marker = Marker(
                                    point: LatLng(
                                      userLocation.lat,
                                      userLocation.long,
                                    ),
                                    child: Icon(
                                      Icons.location_pin,
                                      color: GColors.black,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          text: 'Provide your location',
                          icon: Icons.location_on_outlined,
                        );
                      }

                      //location provided
                      if (state is LocationLoaded) {
                        //* allow user to change location
                        return LocationProvided(
                          onPressed: () => locationCubit.showMapDialog(context,
                              userLocation: userLocation),
                        );
                      }

                      //loading...
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: GColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GlobalLoadingBar(
                              mainText: false,
                            ),
                          ],
                        ),
                      );
                    },
                    listener: (context, state) {
                      //open loading dialog
                      if (state is LocationLoading) {
                        LocationLoadingDialog.show(context);
                      }

                      //close loading dialog
                      if (state is LocationLoaded) {
                        LocationLoadingDialog.close(context);
                      }

                      //error
                      if (state is LocationError) {
                        Navigator.of(context).pop();
                        GSnackBar.show(context: context, text: state.message);
                      }
                    },
                  ),

                  const SizedBox(height: 25),

                  //register button
                  AuthButton(
                    onTap: register,
                    text: 'Register',
                    icon: Icons.arrow_forward_ios,
                  ),

                  const SizedBox(height: 50),

                  //not a member ? register now
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        'You have an accout ? ',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: 17,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login now!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: GColors.royalBlue,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
