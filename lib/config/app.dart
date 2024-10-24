import 'package:events_jo/config/my_progress_indicator.dart';
import 'package:events_jo/features/auth/data/firebase_auth_repo.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_states.dart';
import 'package:events_jo/features/auth/representation/pages/auth_page.dart';
import 'package:events_jo/features/location/data/geolocator_location_repo.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/navigation/presentation/navigation_bar.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_cubit.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Root level

repos for the database
  -firebase

bloc providers 
  -auth
  ...

auth state
  -unauthenticated -> auth page (login/register)
  -authenticated -> home page

*/

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final weddingVenueRepo = FirebaseWeddingVenueRepo();
  final locationRepo = GeolocatorLocationRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //auth cubit
        BlocProvider(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),
        //location cubit
        BlocProvider(
          create: (context) => LocationCubit(locationRepo: locationRepo),
        ),
        //wedding venue cubit
        BlocProvider(
          create: (context) =>
              WeddingVenueCubit(weddingVenueRepo: weddingVenueRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Abel',
          scaffoldBackgroundColor: MyColors.scaffoldBg,
          appBarTheme: AppBarTheme(
            backgroundColor: MyColors.appBarBg,
            iconTheme: IconThemeData(
              color: MyColors.black,
            ),
          ),
          iconTheme: IconThemeData(
            color: MyColors.gray,
          ),
        ),
        home: BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, authState) {
            debugPrint(authState.toString());

            if (authState is Unauthenticated) {
              return const AuthPage();
            }
            if (authState is Authenticated) {
              return const MyNavigationBar();
            } else {
              return Scaffold(
                body: Center(
                  child: MyProgressIndicator(color: MyColors.black),
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
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
      ),
    );
  }
}
