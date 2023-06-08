import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation{
  final double latitude;
  final double longitude;
  final String formattedAddress;

  const PlaceLocation({required this.latitude, required this.longitude, required this.formattedAddress});
}

class Place{
  final String id;
  final String name;
  final File image;
  final PlaceLocation placeLocation;

  Place({
    required this.name,
    required this.image,
    required this.placeLocation,
    String? id
  }):id = id ?? uuid.v4();

}