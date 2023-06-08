import 'package:favorite_places/screens/googlemaps_screen.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);
  final Place place;

  String get locationImage {
    // max's : center=${place.placeLocation.latitude},${place.placeLocation.longitude}
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${place
        .placeLocation.latitude},${place.placeLocation
        .longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C${place
        .placeLocation.latitude},${place.placeLocation
        .longitude}&key=AIzaSyC_pmjURTHAF2LOdZltYmq1AMVuQ8nd4sU';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (ctx) =>
                              MapsScreen(
                                placeLocation: place.placeLocation,
                                isPickingLocation: false,)
                        )
                      );
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(locationImage),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black54
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                        )
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      place.placeLocation.formattedAddress,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onBackground
                      ),
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
