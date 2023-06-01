import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>>{
  PlacesNotifier(): super(
      []
  );

  bool toggleMealFavoriteStatus(Place place){
    final contains = state.contains(place);
    if(contains){
      state = state.where((element) => element.id != place.id).toList();
      return false;
    }
    else{
      state = [...state, place];
      return true;
    }

  }

}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>((ref){
  return PlacesNotifier();
});