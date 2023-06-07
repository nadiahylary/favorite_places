import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();
class PlaceLocation{
  final double latitude;
  final double longitude;
  final String formattedAddress;

  PlaceLocation({required this.latitude, required this.longitude, required this.formattedAddress});
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
  }):id = uuid.v4();

}