import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenueCubit extends Cubit<WeddingVenueStates> {
  final WeddingVenueRepo weddingVenueRepo;

  WeddingVenueCubit({required this.weddingVenueRepo})
      : super(WeddingVenueInit());

  Future<List<WeddingVenue>> getAllVenues() async {
    emit(WeddingVenueLoading());

    final weddingVenuesList = await weddingVenueRepo.getAllVenues();
    emit(WeddingVenueLoaded());
    return weddingVenuesList;
  }
}
