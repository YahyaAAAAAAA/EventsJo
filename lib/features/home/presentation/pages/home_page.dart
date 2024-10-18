import 'package:events_jo/config/custom_icons_icons.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_card.dart';
import 'package:events_jo/features/weddings/data/firebase_wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weddingVenueRepo = FirebaseWeddingVenueRepo();
  late AppUser? currentUser;

  @override
  void initState() {
    super.initState();

    //get user
    currentUser = context.read<AuthCubit>().currentUser!;
  }

  //todo for later
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
          // title: Text(
          //   "Greetings ${currentUser!.name.toCapitalized}\n choose which category you would like to book.",
          //   style: TextStyle(color: MyColors.black, fontSize: 20),
          //   textAlign: TextAlign.center,
          // ),
          // toolbarHeight: 100.0,
          // centerTitle: true,
          ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            //welocme text
            Text(
              "Greetings ${currentUser!.name.toCapitalized}\n Choose which category you would like to book",
              style: TextStyle(color: MyColors.black, fontSize: 22),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            //weddings card -> to weddings page
            HomeCard(
              text: 'Wedding Venues',
              icon: CustomIcons.wedding,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeddingVenuesPage(),
                ),
              ),
            ),

            const SizedBox(height: 25),

            //farms card -> to farms page
            HomeCard(
              text: 'Farms',
              icon: CustomIcons.farm,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeddingVenuesPage(),
                ),
              ),
            ),

            const SizedBox(height: 25),

            //football courtes card -> to football courtes page
            HomeCard(
              text: 'Football Courts',
              icon: CustomIcons.football,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeddingVenuesPage(),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
      // drawer: const MyDrawer(),
    );
  }
}
