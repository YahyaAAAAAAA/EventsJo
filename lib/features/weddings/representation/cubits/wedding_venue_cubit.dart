import 'package:events_jo/config/haversine.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenueCubit extends Cubit<WeddingVenueStates> {
  final WeddingVenueRepo weddingVenueRepo;
  final Haversine haversine = Haversine();

  WeddingVenueCubit({required this.weddingVenueRepo})
      : super(WeddingVenueInit());

  Future<List<WeddingVenue>> getAllVenues() async {
    emit(WeddingVenueLoading());

    final weddingVenuesList = await weddingVenueRepo.getAllVenues();
    emit(WeddingVenueLoaded());

    return weddingVenuesList;
  }

  List<WeddingVenue> sortAlpha(List<WeddingVenue> weddingVenuList) {
    //loading..
    emit(WeddingVenueLoading());

    //start sorting
    weddingVenuList.sort(
      (a, b) => a.name.trim()[0].compareTo(b.name.trim()[0]),
    );

    //state
    emit(WeddingVenueLoaded());

    return weddingVenuList;
  }

  List<WeddingVenue> sortFromClosest(List<WeddingVenue> weddingVenuList) {
    //loading..
    emit(WeddingVenueLoading());

    //same list but sorted from closest to furtherest from the user (as json)
    List sortedList = haversine.getSortedLocations(32.05686218187307,
        36.12490100936145, weddingVenuList.map((e) => e.toJson()).toList());

    //clear list
    weddingVenuList.clear();

    //convert sorted list to wedding venue and add it
    weddingVenuList
        .addAll(sortedList.map((e) => WeddingVenue.fromJson(e)).toList());

    //state
    emit(WeddingVenueLoaded());

    return weddingVenuList;
  }
}
