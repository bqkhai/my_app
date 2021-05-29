import 'package:wemapgl/wemapgl.dart';

class Place {
  final String id;
  final String name;
  final String description;
  final String address;
  final Location location;

  Place ({
    this.id,
    this.name,
    this.description,
    this.address,
    this.location
  });

  WeMapPlace placeInfo() {
    return WeMapPlace(
      placeName: this.name,
      description: this.address,
      location: LatLng(this.location.lat, this.location.lng),
    );
  }

  factory Place.fromJson(Map<String, dynamic> parsedJson) {
    return new Place(
      id: parsedJson['_id'],
      name: parsedJson['name'],
      description: parsedJson['description'],
      address: parsedJson['address'],
      location: Location.fromJson(parsedJson['city']),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    return new Location(
      lat: parsedJson['lat'],
      lng: parsedJson['lng'],
    );
  }
}