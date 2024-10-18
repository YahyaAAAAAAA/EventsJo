import 'package:events_jo/config/haversine.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/config/my_progress_indicator.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/wedding_venue_card.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenuesPage extends StatefulWidget {
  const WeddingVenuesPage({super.key});

  @override
  State<WeddingVenuesPage> createState() => _WeddingVenuesPageState();
}

class _WeddingVenuesPageState extends State<WeddingVenuesPage> {
  late List<WeddingVenue> weddingVenuList = [];
  Haversine haversine = Haversine();

  void sortFromClosest() {
    //same list but sorted from closest to furtherest from the user (as json)
    List sortedList = haversine.getSortedLocations(32.05686218187307,
        36.12490100936145, weddingVenuList.map((e) => e.toJson()).toList());

    //convert sorted list to wedding venue
    weddingVenuList = sortedList.map((e) => WeddingVenue.fromJson(e)).toList();
  }

  void sortAlpha() {
    weddingVenuList.sort(
      (a, b) => a.name.trim()[0].compareTo(b.name.trim()[0]),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //get original list from the database
        weddingVenuList =
            await context.read<WeddingVenueCubit>().getAllVenues();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.beige,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  // sortFromClosest();
                  sortAlpha();
                });
              },
              child: const Icon(Icons.sort))
        ],
      ),
      body: BlocConsumer<WeddingVenueCubit, WeddingVenueStates>(
        builder: (context, state) {
          //loading...
          if (state is WeddingVenueLoading) {
            return Center(
              child: MyProgressIndicator(
                color: MyColors.black,
              ),
            );
          }

          //list ready
          if (state is WeddingVenueLoaded) {
            return ListView.builder(
              itemCount: weddingVenuList.length,
              itemBuilder: (context, index) {
                return WeddingVenueCard(weddingVenue: weddingVenuList[index]);
              },
            );
          } else {
            return const Center(
              child: Text('Error getting venues list'),
            );
          }
        },
        listener: (context, state) {
          //listens for errors
          if (state is WeddingVenueError) {
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
