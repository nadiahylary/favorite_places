import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.onPickLocation}) : super(key: key);
  final void Function(PlaceLocation location) onPickLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isLoadingLocation = false;

  String get locationImage{
    if(_pickedLocation == null){
      return '';
    }
    // max's : center=${place.placeLocation.latitude},${place.placeLocation.longitude}
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${_pickedLocation!.formattedAddress}&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C${_pickedLocation!.latitude},${_pickedLocation!.longitude}&key=AIzaSyC_pmjURTHAF2LOdZltYmq1AMVuQ8nd4sU';
  }

  void _getCurrentLocation() async {

    setState(() {
      _isLoadingLocation = true;
    });

    LocationData locationData = await getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if(latitude == null || longitude == null){
      return;
    }

    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyC_pmjURTHAF2LOdZltYmq1AMVuQ8nd4sU');

    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
          latitude: latitude,
          longitude: longitude,
          formattedAddress: address
      );
      _isLoadingLocation = false;
    });
    print("Location: ${locationData.latitude}, ${locationData.longitude}");

  }

  @override
  Widget build(BuildContext context) {
    Widget containerContent = Text(
      "No Location Chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
      ));
    if(_pickedLocation != null){
      containerContent = Image.network(locationImage, fit: BoxFit.cover, width: double.infinity, height: double.infinity,);
    }

    if(_isLoadingLocation){
      containerContent = const CircularProgressIndicator();
    }

    return Column(children: [
      Container(
        height: 150,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(5),

        ),
        child: containerContent,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(
                Icons.location_on
              ),
              label: const Text("Get Current Location")
          ),
          TextButton.icon(
              onPressed: (){},
              icon: const Icon(
                  Icons.map
              ),
              label: const Text("Choose a Location on Map")
          ),
        ],
      ),
    ],
    );
  }
}
