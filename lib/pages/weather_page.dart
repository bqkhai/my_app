import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/ePage.dart';
import 'package:my_app/services/weather_response.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;
import 'package:wemapgl/wemapgl.dart';
import 'package:http/http.dart' as http;



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
  static final WEMAP.CameraPosition _initialLocation = WEMAP.CameraPosition(target: WEMAP.LatLng(21.059686, 105.779383), zoom: 15.0);
  LatLng myLatLng = LatLng(21.038195, 105.782694);
  WeMapPlace place;
  final String apiKey = '9f566121a09100585fa23c378331374e';
  WeatherResponse weatherResponse;

  void _onMapCreated(WEMAP.WeMapController controller) {
    mapController = controller;
  }

  void _getWeather(double lat, double lon) async{
    //var url = 'http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=$apiKey&units=metric';
    var url = 'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      //String data = response.body.toString();
      // var city = jsonDecode(data)['name'];
      // var description = jsonDecode(data)['weather'][0]['description'];
      // var temp = jsonDecode(data)['main']['temp'];
      // print('Welcome to $city!');
      // print('Weather: $description');
      // print('Temperature: $temp °C'); 
      setState(() {
        weatherResponse = WeatherResponse.fromJSON(jsonDecode(response.body));
      });
    } else {
      print(response.statusCode);
      // print('Latitude is: $lat *** Longitude is: $lon');
      // print('response $url');
      throw Exception ('Failed to load weather data');
    }
  }

  void _onMapClick(point, latlng, _place) async {
    place = _place;
    print("Map click: ${point.x},${point.y}   ${latlng.latitude}/${latlng.longitude}");
    _getWeather(latlng.latitude, latlng.longitude);
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   title: Text(""),
      //   backgroundColor: Colors.white,
      // ),
      body: Stack(
        children: [
          WEMAP.WeMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialLocation,
            onMapClick: _onMapClick,
          ),
          Container(
            child: new ListView(
              children: <Widget>[
                Text(
                  weatherResponse.city,
                  style: TextStyle(fontSize: 18),
                ),
                Text(weatherResponse.description),
                Text(weatherResponse.temperature.toString()),
              ]
            ) ,
          ),
          WEMAP.WeMapSearchBar(
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
            },
            onClearInput: () {
              setState(() {
                place = null;
                mapController.showPlaceCard?.call(place);
              });
            },
          ),
        ],
      )
    );
  }
}