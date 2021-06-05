import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/data_models/place.dart';
import 'package:my_app/shared/constants.dart';
import 'package:wemapgl/wemapgl.dart';
import 'ePage.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;


class ExplorePage extends EPage{
  static const String idScreen = 'explore';
  ExplorePage(): super(const Icon(Icons.map), 'Explore');
  @override
  Widget build(BuildContext context){
    return Explore();
  }
}


class Explore extends StatefulWidget{
  const Explore();
  @override
  State createState() => ExploreState();
}


class ExploreState extends State<Explore> {
  WeMapController mapController;
  WeMapPlace mapPlace;
  LocationData currentLocation;

  final String _placeFavouriteIcon = "assets/symbols/2.0x/placefavourite.png";
  final String _placeMarkerIcon = "assets/symbols/2.0x/placemarker.png";
  Symbol _focusPlaceSymbol;

  final int searchType = 1;
  final LatLng _myLatLng = LatLng(21.03765756214673, 105.78163419961048);
  bool _myLocationEnabled = false;

  bool _isShowPlaceCard = false;
  // ignore: unused_field
  bool _isShowPlaceWeather = false;


  Future<Symbol> _addSymbol(LatLng location,
      [String type = 'place', Place place]) {
    Map data = {"type": type, "place": place};
    var icon;
    switch (type) {
      case 'place':
        icon = _placeFavouriteIcon;
        break;
      default:
        icon = _placeMarkerIcon;
    }
    return mapController.addSymbol(
      SymbolOptions(
        geometry: location,
        iconImage: icon,
      ),
      data,
    );
  }

  void _onMapCreated(WeMapController controller) {
    mapController = controller;
    mapController.onSymbolTapped.add(_onSymbolTapped);
  }

  void _onSelected(place) {
    print('select');
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: place.location,
          zoom: 15.0,
        ),
      ),
    );
    _focusPlace(place);
  }

  void _onSymbolTapped(Symbol symbol) {
    print('on symbol tapped');
    final place = symbol.data['place'];
    if (place != null) {
      _focusPlace(place);
      _getWeather(place);
    }
  }

  void _focusPlace(WeMapPlace place) {
    if (mapPlace == null && _focusPlaceSymbol == null) {
      _addSymbol(place.location, 'tappedMapSymbol').then((symbol) {
        _focusPlaceSymbol = symbol;
      });
      setState(() {
        mapPlace = place;
        _isShowPlaceCard = true;
        _isShowPlaceWeather = true;
      });
    } else if (mapPlace != null && _focusPlaceSymbol != null) {
      mapController.updateSymbol(
        _focusPlaceSymbol,
        SymbolOptions(geometry: place.location),
      );
      setState(() {
        mapPlace = place;
        _isShowPlaceCard = true;
        _isShowPlaceWeather = true;
      });
    } else {
      print('error focus place');
    }
  }

  void _unfocusPlace() {
    if (_focusPlaceSymbol != null) {
      mapController.removeSymbol(_focusPlaceSymbol);
    }
    setState(() {
      mapPlace = null;
      _focusPlaceSymbol = null;
      _isShowPlaceCard = false;
      _isShowPlaceWeather = false;
    });
  }


  var celsius;
  var city;
  var description;
  var iconUrl;

  Future<void> _getWeather(WeMapPlace place) async {
    double lat = place.location.latitude;
    double lon = place.location.longitude;

    var url = 'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiWeatherKey&units=metric';

    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      String data = response.body;
      celsius = jsonDecode(data)['main']['temp'];
      city = jsonDecode(data)['name'];
      description = jsonDecode(data)['weather'][0]['description'];
      //iconUrl = "http://openweathermap.org/img/w/" + jsonDecode(data)["weather"]["icon"] +".png";
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw Exception ('Failed to load weather data');
    }
  }

  void _onMapClick(point, latlng, place) {
    print('Map click');
    _focusPlace(place);
    _getWeather(place);
  }

   
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          WeMap(
            myLocationEnabled: _myLocationEnabled,
            myLocationRenderMode: MyLocationRenderMode.NORMAL,
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            onMapClick: _onMapClick,
            reverse: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _myLatLng,
              zoom: 15.0,
            ),
            destinationIcon: "assets/symbols/destination.png",
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: WeMapSearchBar(
                      location: (currentLocation != null)
                        ? (LatLng(currentLocation.latitude,
                          currentLocation.longitude))
                        : _myLatLng,
                      searchValue:
                          (mapPlace != null) ? mapPlace.placeName : null,
                      showYourLocation: false,
                      hintText: 'Tìm kiếm',
                      onSelected: _onSelected,
                      onClearInput: _unfocusPlace,
                    ),
                  ),
                ],
              ),
              Spacer(),
              (_isShowPlaceCard && mapPlace != null)
                ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.place_rounded, size: 30.0, color: Colors.green,),
                          title: Text(mapPlace.placeName),
                          subtitle: Text(mapPlace.description),
                        ),
                        ListTile(
                          leading: Icon(Icons.info, color: Colors.amber,),
                          title: Text('Welcome to: $city'),
                          subtitle: Text('Temp: $celsius °C, Desc: $description'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('CHỈ ĐƯỜNG'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WeMapDirection(
                                      originIcon: "assets/symbols/origin.png",
                                      destinationIcon: "assets/symbols/destination.png",
                                      destinationPlace: mapPlace,
                                    )
                                  ),
                                );
                              }),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('BẮT ĐẦU'),
                                onPressed: (){},
                              ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  )
                )
                : Align()    
            ],
          ),
        ],
      ),
    );
  }
}