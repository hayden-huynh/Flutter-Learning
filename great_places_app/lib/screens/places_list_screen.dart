import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (ctx, greatPlaces, child) => greatPlaces.items.length <= 0
            ? child
            : ListView.builder(
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[i].image),
                  ),
                  title: Text(greatPlaces.items[i].title),
                  onTap: () {},
                ),
                itemCount: greatPlaces.items.length,
              ),
        child: Center(
          child: const Text('No places yet. Start adding some!'),
        ),
      ),
    );
  }
}
