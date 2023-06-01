
import 'package:favorite_places/places_provider.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import '../screens/new_place.dart';


class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(placesProvider);

    void newPlaceScreen() async {
      final newPlaceItem = await Navigator.of(context).push<Place>(
          MaterialPageRoute(builder: (ctx) => const NewPlaceScreen()));
      if(newPlaceItem == null){
        return;
      }
      setState(() {
        placesList.add(newPlaceItem);
      });
    }

    Widget mainContent = Center(
      child: Container(
        height: 400,
        margin: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "You have no saved places yet.",
            ),
          ],
        ),
      ),
    );

    if (placesList.isNotEmpty) {
      mainContent = PlacesList(placesList);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gr8t Places"),
        actions: [
          IconButton(
            onPressed: newPlaceScreen,
            icon: const Icon(
              Icons.add,
              size: 30,
            ),

          ),
        ],
      ),
      body: mainContent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: newPlaceScreen,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}