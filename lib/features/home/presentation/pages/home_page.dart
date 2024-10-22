import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/events_jo_logo.dart';
import 'package:events_jo/features/home/presentation/components/home_card.dart';
import 'package:events_jo/features/home/presentation/components/my_drawer.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weddingVenueRepo = FirebaseWeddingVenueRepo();
  late AppUser? currentUser;
  late Position? location;
  //dev delete or use it later ?
  String imgSwitch = '';

  @override
  void initState() {
    super.initState();

    //get user
    currentUser = context.read<AuthCubit>().currentUser!;

    //get user location
    location = context.read<LocationCubit>().userLocation;

    //dev delete
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        print(
          await context.read<LocationCubit>().getUserAddress(
                latitude: location!.latitude,
                longitude: location!.longitude,
              ),
        );
      },
    );
  }

  //dev for later
  Widget addToDatabaseButton() {
    return TextButton(
      onPressed: () async {
        //* adding new venus to database (for me)
        // WeddingVenue weddingVenue = WeddingVenue(
        //   latitude: "31.84480325226184",
        //   longitude: "35.88135319995705",
        //   name: "country club".capitalize(),
        //   openTime: "10 AM–10 PM",
        // );
        // FirebaseFirestore.instance
        //     .collection('venues')
        //     .add(weddingVenue.toJson());
      },
      child: const Text('add to database'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person,
                color: MyColors.black,
              ),
              const SizedBox(width: 5),
              Text(
                currentUser!.name.toCapitalized,
                style: TextStyle(
                  color: MyColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        children: [
          //logo
          const EventsJoLogo(),

          //spacing
          Divider(
            thickness: 0.2,
            color: MyColors.black,
            indent: 100,
            endIndent: 100,
          ),

          //welocme text
          Text(
            "Choose which category you would like to book",
            style: TextStyle(
              color: MyColors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),

          //spacing
          const SizedBox(height: 20),

          //weddings card -> to weddings page
          HomeCard(
            text: 'Wedding Venues',
            subText: 'See wedding venues in Jordan',
            image: 'assets/images/wedding_ring.png',
            width: 110,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WeddingVenuesPage(),
              ),
            ),
          ),

          //spacing
          Divider(thickness: 0.2, color: MyColors.black),

          HomeCard(
            text: 'Personal Event',
            subText: 'Book your own in-house event',
            image: 'assets/images/person.png',
            width: 100,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WeddingVenuesPage(),
              ),
            ),
          ),

          //spacing
          Divider(thickness: 0.2, color: MyColors.black),

          //farms card -> to farms page
          HomeCard(
            text: 'Farms',
            subText: 'See farms in Jordan',
            image: 'assets/images/farm.png',
            width: 110,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WeddingVenuesPage(),
              ),
            ),
          ),

          //spacing
          Divider(thickness: 0.2, color: MyColors.black),
          const SizedBox(height: 20),

          //football courtes card -> to football courtes page
          HomeCard(
            text: 'Football Courts',
            subText: 'See football courts in Jordan',
            image: 'assets/images/football.png',
            leftPadding: 10,
            width: 110,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WeddingVenuesPage(),
              ),
            ),
          ),

          //spacing
          Divider(thickness: 0.2, color: MyColors.black),
        ],
      ),

      //dev delete later
      drawer: const MyDrawer(),
    );
  }
}
