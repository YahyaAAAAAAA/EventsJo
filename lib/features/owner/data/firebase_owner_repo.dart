import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseOwnerRepo implements OwnerRepo {
  //setup cloudinary server (for image upload & removal)
  final cloudinary = Cloudinary.full(
    apiKey: dotenv.get('IMG_API_KEY'),
    apiSecret: dotenv.get('IMG_API_SECRET'),
    cloudName: dotenv.get('IMG_CLOUD_NAME'),
  );

  @override
  Future<void> addVenueToDatabase({
    required String name,
    required double lat,
    required double long,
    required String ownerId,
    required String ownerName,
    required int peopleMax,
    required int peopleMin,
    required double peoplePrice,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    List<String>? pics,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  }) async {
    //set venue id
    final String docId = generateUniqueId();

    //create weddingVenue object
    WeddingVenue weddingVenue = WeddingVenue(
      id: docId,
      latitude: lat,
      longitude: long,
      name: name.toTitleCase,
      startDate: startDate,
      endDate: endDate,
      time: time,
      isOpen: true,
      isApproved: false,
      isBeingApproved: false,
      peopleMax: peopleMax,
      peopleMin: peopleMin,
      peoplePrice: peoplePrice,
      ownerId: ownerId,
      ownerName: ownerName,
      pics: pics ??
          [
            'https://i.ibb.co/ZVf53hB/placeholder.png',
          ],
      rate: 0,
      city: await getCity(lat, long) ?? '  ',
    );

    // add new venue to database
    await FirebaseFirestore.instance
        .collection('venues')
        .doc(docId)
        .set(weddingVenue.toJson());

    //team we use (set) instead of (add) so we can specify the id
    //in this case we have the id as (current time) + (rand num) because it's always unique
    //if (add) is used Firebase will generate random id.

    //------------------Meals---------------------

    await addVenueMealsToDatabase(meals, docId);

    //------------------Drinks--------------------

    await addVenueDrinksToDatabase(drinks, docId);
  }

  @override
  Future<String?> getCity(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      return placemarks[0].locality;
    } catch (e) {
      return '  ';
    }
  }

  @override
  Future<void> addVenueMealsToDatabase(
      List<WeddingVenueMeal>? meals, String docId) async {
    //user didn't add meals
    if (meals == null || meals.isEmpty) {
      return;
    }

    //fixed meals id
    for (int i = 0; i < meals.length; i++) {
      meals[i].id = (i + 1).toString();
    }

    //add meals collection to user's venue
    //then add user's individual meals
    for (int i = 0; i < meals.length; i++) {
      await FirebaseFirestore.instance
          .collection('venues')
          .doc(docId)
          .collection('meals')
          .doc(meals[i].id)
          .set(meals[i].toJson());
    }
  }

  @override
  Future<void> addVenueDrinksToDatabase(
      List<WeddingVenueDrink>? drinks, String docId) async {
    //user didn't add drinks
    if (drinks == null || drinks.isEmpty) {
      return;
    }

    //fixed drinks id
    for (int i = 0; i < drinks.length; i++) {
      drinks[i].id = (i + 1).toString();
    }

    //add drinks collection to user's venue
    //then add user's individual drinks
    for (int i = 0; i < drinks.length; i++) {
      await FirebaseFirestore.instance
          .collection('venues')
          .doc(docId)
          .collection('drinks')
          .doc(drinks[i].id)
          .set(drinks[i].toJson());
    }
  }

  @override
  Future<List<String>> addImagesToServer(
      List<XFile> images, String name) async {
    List<String> urls = [];
    urls.clear();

    final time = DateTime.now().millisecond;

    // request upload to server
    for (int i = 0; i < images.length; i++) {
      var response = await cloudinary.uploadResource(
        CloudinaryUploadResource(
          filePath: images[i].path,
          fileBytes: await images[i].readAsBytes(),
          folder: '$name-$time',
          resourceType: CloudinaryResourceType.image,
        ),
      );

      if (response.isSuccessful) {
        urls.add(response.secureUrl ?? '');
      }
    }

    return urls;
  }

  @override
  String generateUniqueId() {
    //current time (from year to microsecond)
    final now = DateTime.now();
    //get random number between 0 and 99999
    int randomValue = Random().nextInt(100000);

    //id example -> 2024111609413072511999
    return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.microsecond}$randomValue";
  }
}
