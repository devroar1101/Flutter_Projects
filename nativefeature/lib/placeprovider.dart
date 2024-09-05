import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nativefeature/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

final placeProvider =
    StateNotifierProvider<PlaceProviderState, List<Place>>((fn) {
  return PlaceProviderState();
});

class PlaceProviderState extends StateNotifier<List<Place>> {
  PlaceProviderState() : super([]);

  void onAddNewPlace(title, image, location) async {
    //created copy of place and store it in database

 
    

    

    Place place = Place(title: title!, image: image, location: location!);

    bool isExist = state.contains(place);
    if (isExist) {
      state = state.where((p) => p.id != place.id).toList();
      
    } else {
      state = [...state, place];
      
    }
  }
}
