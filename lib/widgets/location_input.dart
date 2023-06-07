import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  //Location? _pickedLocation;
  var _isLoadingLocation = false;

  void _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    final location = await getLocation();

    setState(() {
      _isLoadingLocation = true;
    });
    print("Location: ${location.latitude}, ${location.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    Widget containerContent = Text(
      "No Location Chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
      ));
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
