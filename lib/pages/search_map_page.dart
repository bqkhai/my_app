import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;

import 'ePage.dart';

class SearchMapPage extends EPage{
  SearchMapPage() : super(const Icon(Icons.map), 'Search map');

  @override
  Widget build(BuildContext context) {
    return const SearchMap();
  }
}

class SearchMap extends StatefulWidget {
  const SearchMap();

  @override
  State createState() => SearchMapState();
}

class SearchMapState extends State<SearchMap> {
  WEMAP.WeMapController mapController;
  int searchType = 1;
  String searchInfoPlace = "Tìm kiếm";
  LatLng myLatLng = LatLng(21.038195, 105.782694);
  bool reverse = true;
  WeMapPlace place;


  void _onMapCreated(WeMapController controller) {
    mapController = controller;
  }

  // void _add(String iconImage) {
  //   var latLng = ;
  //   mapController.addSymbol(
  //     SymbolOptions(
  //       geometry: latLng,
  //       iconImage: iconImage,
  //     ),
  //   );
  //   setState(() {
  //   });
  // }

  Future<void> _addMarker(latLng, controller, iconImage) async {
    await mapController?.addSymbol(SymbolOptions(
      geometry: latLng,
      iconImage: iconImage,
      iconAnchor: "bottom",
    ));
  }

  void _onMapClick(point, latlng, _place) async {
    place = _place;
    print("Map click: ${point.x},${point.y}   ${latlng.latitude}/${latlng.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          WeMap(
            onMapClick: _onMapClick,
            onPlaceCardClose: (){},
            reverse: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.036029, 105.782950),
              zoom: 15.0,
            ),
            destinationIcon: "assets/symbols/destination.png",       
          ),
          WeMapSearchBar(
            location: myLatLng,
            onSelected: (_place) {
              setState(() {
                place = _place;
              });
              mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: place?.location, zoom: 15.0),
                ),
              );
              mapController.showPlaceCard?.call(place);  
              //_addMarker();
            },
            onClearInput: () {
              setState(() {
                place = null;
                mapController.showPlaceCard?.call(place);
              });
            },
          ),
        ],
      ),
    );
  }
}
