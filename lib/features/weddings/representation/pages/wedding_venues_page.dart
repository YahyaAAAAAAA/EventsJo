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
  late final WeddingVenueCubit cubit;

  @override
  void initState() {
    super.initState();

    //get cubit
    cubit = context.read<WeddingVenueCubit>();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //get original list
        weddingVenuList = await cubit.getAllVenues();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                cubit.sortFromClosest(weddingVenuList);
                // cubit.sortAlpha(weddingVenuList);
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
          }
          //error state
          else {
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
