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
        selectedItemColor: Colors.redAccent,
        onTap: _setCurrentIndex,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.black87),
            label: 'Home',
            backgroundColor: Colors.grey[200],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, color: Colors.black87,),
            label: 'Explore',
            backgroundColor: Colors.grey[200],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions, color: Colors.black87),
            label: 'Go',
            backgroundColor: Colors.grey[200],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny, color: Colors.black87),
            label: 'Weather',
            backgroundColor: Colors.grey[200],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black87),
            label: 'Profile',
            backgroundColor: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
