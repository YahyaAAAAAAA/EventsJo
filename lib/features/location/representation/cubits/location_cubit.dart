import 'dart:async';

import 'package:events_jo/features/location/domain/location_repo.dart';
import 'package:events_jo/features/location/representation/cubits/location_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationStates> {
  final LocationRepo locationRepo;
  Position? _userLocation;

  LocationCubit({required this.locationRepo}) : super(LocationInitial());

  Future<Position?> getUserLocation() async {
    //loading...
    emit(LocationLoading());
    try {
      final Position location = await locationRepo.getUserLocation();

      _userLocation = location;

      //done
      emit(LocationLoaded(location));
      return location;
    } catch (e) {
      //error
      emit(LocationError(e.toString()));
      return null;
    }
  }

  //todo get the address probly,
  //dev fix
  Future<String?> getUserAddress(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first.country;
  }

  Position? get userLocation => _userLocation;
}
