import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>>{
  PlacesNotifier(): super(
     []
  );

  /*bool addPlaceToPlaces(Place place){
    final contains = state.contains(place);
    if(contains){
      state = state.where((element) => element.id != place.id).toList();
      return false;
    }
    else{
      state = [...state, place];
      return true;
    }

  }*/

  void addPlace(Place place){
    state = [...state, place];
  }

}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>((ref){
  return PlacesNotifier();
});