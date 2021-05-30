import 'package:flutter/material.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/explore_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/route_page.dart';
import 'package:my_app/pages/search_map_page.dart';
import 'package:my_app/pages/weather_page.dart';



// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  int index;
  static const String idScreen = 'BottomNavbar';

  BottomNavBar(this.index);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _child = [
    HomePage(),
    ExplorePage(),
    RoutePage(),
    WeatherPage(),
    ProfilePage(),
  ];
  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: _child[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _setCurrentIndex,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Home',
            backgroundColor: Colors.blueGrey[400],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Explore',
            backgroundColor: Colors.green[400],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            label: 'Go',
            backgroundColor: Colors.purple[400],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Colors.pink[300],
          ),
        ],
      ),
    );
  }
}
