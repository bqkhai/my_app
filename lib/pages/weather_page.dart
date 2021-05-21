import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/ePage.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;



class WeatherPage extends EPage {
  WeatherPage() : super(const Icon(Icons.find_in_page), 'Weather');

  @override
  Widget build(BuildContext context) {
    return const Weather();
  }
}

class Weather extends StatefulWidget {
  const Weather();

  @override
  State createState() => WeatherState();
}

class WeatherState extends State<Weather>{

  WEMAP.WeMapController mapController;
  // ignore: unused_field
  static final WEMAP.CameraPosition _initialLocation = WEMAP.CameraPosition(target: WEMAP.LatLng(21.059686, 105.779383), zoom: 16.00);

  void _onMapCreated(WEMAP.WeMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.white,
      ),
      body: WEMAP.WeMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialLocation,
        
      ),
    );
  }
}