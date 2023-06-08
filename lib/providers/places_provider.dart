import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

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
  Future<Database> _getDatabase() async {
    final dbPath =  await sql.getDatabasesPath();
    final placeDb = await sql.openDatabase(
        path.join(dbPath, 'favorites_places.db'),
        onCreate: (db, version){
          return db.execute('CREATE TABLE places(id TEXT primary key, name TEXT, image TEXT, lat REAL, longt REAL, address TEXT)');
        },
        version: 1
    );
    return placeDb;

  }
  Future<void> loadPlaces() async {
    final placeDb = await _getDatabase();
    final data = await placeDb.query('places');
    final places = data.map((row) => Place(
        id: row['id'] as String,
        name: row['name'] as String,
        image: File(row['image'] as String),
        placeLocation: PlaceLocation(
            latitude: row['lat'] as double,
            longitude: row['longt'] as double,
            formattedAddress: row['address'] as String
        )
      )
    ).toList();
    state = places;
  }

  void addPlace(Place place) async{
    final placeDb = await _getDatabase();
    placeDb.insert('places', {
      'id': place.id,
      'name': place.name,
      'image': place.image.path,
      'lat': place.placeLocation.latitude,
      'longt': place.placeLocation.longitude,
      'address': place.placeLocation.formattedAddress
    });
    _getDatabase();
    state = [...state, place];
  }

}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>((ref){
  return PlacesNotifier();
});