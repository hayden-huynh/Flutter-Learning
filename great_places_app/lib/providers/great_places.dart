import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    );

    _items.add(newPlace);

    notifyListeners();
  }
}
