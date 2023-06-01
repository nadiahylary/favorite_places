
import 'package:favorite_places/places_provider.dart';
import 'package:favorite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import '../screens/new_place.dart';


class PlacesList extends ConsumerStatefulWidget {
  const PlacesList(this._places, {Key? key}) : super(key: key);
  final List<Place> _places;

  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {

  /*void newPlaceScreen() async {
    final newPlaceItem = await Navigator.of(context).push<Place>(
        MaterialPageRoute(builder: (ctx) => const NewPlaceScreen()));
    if(newPlaceItem == null){
      return;
    }
    setState(() {
      widget._places.add(newPlaceItem);
    });
  }*/

  void _deleteGroceryItem(Place place) async {
    final placeIndex = widget._places.indexOf(place);
    setState(() {
      widget._places.remove(place);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      duration: const Duration(seconds: 3),
      content: const Text("Place Deleted."),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              widget._places.insert(placeIndex, place);
            });
          }),
    ));
    }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.5),
          ),
          onDismissed: (direction){
            _deleteGroceryItem( widget._places[index]);
          },
          key: ObjectKey(widget._places[index]),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => PlaceDetailScreen(place: widget._places[index])));
            },
            child: Text(widget._places[index].name, style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary
            ),),
          ),
        );
      },
      itemCount: widget._places.length,
    );
  }
}