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
    // ignore: await_only_futures
    await fetchSearch(input);
    // ignore: await_only_futures
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
