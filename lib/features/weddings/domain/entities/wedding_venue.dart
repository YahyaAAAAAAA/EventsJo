class WeddingVenue {
  late String name;
  late String openTime;
  late String latitude;
  late String longitude;

  WeddingVenue({
    required this.name,
    required this.openTime,
    required this.latitude,
    required this.longitude,
  });

  //convert wedding venue to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'openTime': openTime,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  //convert json to wedding venue
  WeddingVenue.fromJson(Map<String, dynamic> jsonVenue) {
    name = jsonVenue['name'];
    openTime = jsonVenue['openTime'];
    latitude = jsonVenue['latitude'];
    longitude = jsonVenue['longitude'];
  }
}
