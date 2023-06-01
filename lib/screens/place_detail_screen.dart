import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gr8t Places"),
      ),
      body: Center(
        child: Text(
          place.name
        ),
      ),

    );
  }
}
