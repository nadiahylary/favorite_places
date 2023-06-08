import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    Key? key,
    this.placeLocation = const PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
        formattedAddress: ' '),
    this.isPickingLocation = true,
  }) : super(key: key);

  final PlaceLocation placeLocation;
  final bool isPickingLocation;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isPickingLocation ? "Pick a Location" : "Your Favorite Place Location"
        ),
        actions: [
          if(widget.isPickingLocation)
            IconButton(
              onPressed: () {
                Navigator.pop(context, selectedLocation);
              },
              icon: const Icon(
                Icons.save
              ),
          )
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isPickingLocation ? null : (position){
          setState(() {
            selectedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.placeLocation.latitude,
              widget.placeLocation.longitude,
            ),
            zoom: 16,
        ),
        markers: (selectedLocation == null && widget.isPickingLocation) ? {} : {
          Marker(
            markerId: const MarkerId("marker1"),
            position: selectedLocation ?? LatLng(
                  selectedLocation!.latitude,
                  selectedLocation!.longitude
              )
          ),
        },
      ),
    );
  }
}
