import 'package:flutter/material.dart';
import 'package:my_app/pages/about_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/route_page.dart';
import 'package:my_app/pages/search_map_page.dart';


// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  int index;

  BottomNavBar(this.index);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _child = [
    HomePage(),
    RoutePage(),
    SearchMapPage(),
    AboutPage(),
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

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Route',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'About',
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
