import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File
      image; // Type of 'File' because the image is stored in the File System on the device

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
