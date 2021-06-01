// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:my_app/pages/ePage.dart';
// import 'package:my_app/services/weather/weather_response.dart';
// import 'package:wemapgl/wemapgl.dart' as WEMAP;
// import 'package:wemapgl/wemapgl.dart';
// import 'package:http/http.dart' as http;


// class WeatherPage extends EPage {
//   WeatherPage() : super(const Icon(Icons.find_in_page), 'Weather');
//   @override
//   Widget build(BuildContext context) {
//     return const Weather();
//   }
// }

// class Weather extends StatefulWidget {
//   const Weather();
//   @override
//   State createState() => WeatherState();
// }


// class WeatherState extends State<Weather>{
//   WEMAP.WeMapController mapController;
//   static final WEMAP.CameraPosition _initialLocation = WEMAP.CameraPosition(target: WEMAP.LatLng(21.059686, 105.779383), zoom: 15.0);
//   LatLng myLatLng = LatLng(21.038195, 105.782694);
//   WeMapPlace place;
//   final String apiKey = '9f566121a09100585fa23c378331374e';
//   WeatherResponse weatherResponse;

//   void _onMapCreated(WEMAP.WeMapController controller) {
//     mapController = controller;
//   }

//   void _getWeatherOfCity(LatLng latlng) async{
//     double lat = latlng.latitude;
//     double lon = latlng.longitude;
//     var url = 'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
//     var response = await http.get(Uri.parse(url));
//     if(response.statusCode == 200){
//       String data = response.body.toString();
//       var city = jsonDecode(data)['name'];
//       var description = jsonDecode(data)['weather'][0]['description'];
//       var temp = jsonDecode(data)['main']['temp'];
//       print('Welcome to $city!');
//       print('Weather: $description');
//       print('Temperature: $temp °C'); 
//       //return jsonDecode(data);
//     } else {
//       print(response.statusCode);
//       throw Exception ('Failed to load weather data');
//     }
//   }

//   void _onMapClick(point, latlng, _place) async {
//     place = _place;
//     print("Map coordinates: ${point.x},${point.y}   ${latlng.latitude}/${latlng.longitude}");
//     _getWeatherOfCity(latlng);
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack (
//         children: <Widget>[
//           WEMAP.WeMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: _initialLocation,
//             onMapClick: (point, latlng, _place){
//               place = _place;
//               print("Map coordinates: ${point.x},${point.y}   ${latlng.latitude}/${latlng.longitude}");
//               _getWeatherOfCity(latlng);
//             }
//           ),
          
//           WEMAP.WeMapSearchBar(
//             location: myLatLng,
//             onSelected: (_place) {
//               setState(() {
//                 place = _place;
//               });
//               mapController.moveCamera(
//                 CameraUpdate.newCameraPosition(
//                   CameraPosition(target: place?.location, zoom: 15.0),
//                 ),
//               );
//               mapController.showPlaceCard?.call(place);
//             },
//             onClearInput: () {
//               setState(() {
//                 place = null;
//                 mapController.showPlaceCard?.call(place);
//               });
//             },  
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_app/data_models/weather.dart';
// import 'package:my_app/shared/constants.dart';


// class WeatherPage extends StatefulWidget {
//   @override
//   WeatherPageState createState() => WeatherPageState();
// }

// class WeatherPageState extends State<WeatherPage> {
//   WeatherModel weather = WeatherModel();
//   static String location = "Ha Noi";
//   bool _isLoading = true;
//   var baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiWeatherKey&units=metric";

//   Future getWeather() async {
//     var response = await http.get(Uri.parse(baseUrl));
//     setState(() {
//       weather = WeatherModel.fromJson(
//         json.decode(response.body),
//       );
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getWeather();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
//         ? Center(
//           child: CircularProgressIndicator(),
//         )
//         : Stack(children: [
//           Container(
//             child: Image.asset(
//               weather.weather[0].main == "Clear"
//                 ? "assets/sunny.jpg"
//                 : (weather.weather[0].main == "Rain")
//                 ? "assets/rainy.jpg"
//                 : "assets/cloudy.jpeg",
//                 fit: BoxFit.cover,
//                 height: double.infinity,
//                 width: double.infinity,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(color: Colors.black38),
//           ),
//           Container(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         weather.name,
//                         style: GoogleFonts.lato(
//                           fontSize: 35,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             weather.main.temp.toString(),
//                             style: GoogleFonts.lato(
//                               fontSize: 85,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             weather.weather[0].description,
//                             style: GoogleFonts.lato(
//                               fontSize: 25,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 40),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.white30,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               Text('Wind',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 weather.wind.speed.toString(),
//                                 style: GoogleFonts.lato(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 'km/h',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Pressure',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 weather.main.pressure.toString(),
//                                 style: GoogleFonts.lato(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 'hPa',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Humidity',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 weather.main.humidity.toString(),
//                                 style: GoogleFonts.lato(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 '%',
//                                 style: GoogleFonts.lato(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ]
//       ),
//     );
//   }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class WeatherPage extends StatefulWidget {
  static const String idScreen = 'weather';
  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  int temperature;
  String location = 'Ha Noi';
  int woeid = 1236594;
  String weatherSplit = 'clear';
  String weatherInfo;
  String abbreviation = '';
  String errorMessage = '';

  String searchApiUrl = 'https://www.metaweather.com/api/location/search/?query=';
  String locationApiUrl = 'https://www.metaweather.com/api/location/';

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchSearch(String input) async {
    try {
      var searchResult = await http.get(searchApiUrl + input);
      var result = jsonDecode(searchResult.body)[0];
      errorMessage = '';

      setState(() {
        location = result["title"];
        woeid = result["woeid"];
      });
    } catch (error) {
      setState(() {
        errorMessage = 'No data available. Try another City';
      });
    }
  }

  void fetchLocation() async {
    var locationResult = await http.get(locationApiUrl + woeid.toString());
    var result = jsonDecode(locationResult.body);
    var consolidatedWeather = result["consolidated_weather"];
    var data = consolidatedWeather[0];

    setState(() {
      temperature = data["the_temp"].round();
      weatherInfo = data["weather_state_name"];
      weatherSplit = data["weather_state_name"].replaceAll(' ', '').toLowerCase();
      abbreviation = data["weather_state_abbr"];
    });
    print(abbreviation);
    print(temperature);
    print(weatherInfo);
  }

  void onTextFieldSubmitted(String input) async {
    await fetchSearch(input);
    await fetchLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$weatherSplit.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: temperature == null
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: Image.network(
                        'https://www.metaweather.com/static/img/weather/png/$abbreviation.png',
                        width: 100
                      ),
                    ),
                    Center(
                      child: Text(
                        temperature.toString() + ' °C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60.0,
                        ),
                      ),
                    ),
                    Center(
                      child:  Text(
                        weatherInfo,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: TextField(
                        onSubmitted: (String input) {
                          onTextFieldSubmitted(input);
                        },
                        style:
                          TextStyle(
                            color: Colors.white, 
                            fontSize: 25.0
                          ),
                        decoration: InputDecoration(
                          hintText: 'Enter City',
                          hintStyle: TextStyle(
                            color: Colors.white, 
                            fontSize: 18.0
                          ),
                          prefixIcon:
                            Icon(
                              Icons.search, 
                              color: Colors.white
                            ),
                        ),
                      ),
                    ),
                    Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}
