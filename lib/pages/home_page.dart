import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/about_page.dart';
import 'package:my_app/pages/route_page.dart';
import 'package:my_app/pages/search_map_page.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;
import 'package:flutter/services.dart';
import 'package:location/location.dart';


class HomePage extends StatefulWidget {
  static String routeName = '/home';
  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  WEMAP.WeMapController mapController;
  String _styleString = WEMAP.WeMapStyles.WEMAP_VECTOR_STYLE;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

  static final WEMAP.CameraPosition _initialLocation = WEMAP.CameraPosition(target: WEMAP.LatLng(21.059686, 105.779383), zoom: 16.00);

  void _onMapCreated(WEMAP.WeMapController controller) async {
    mapController = controller;
  }

  void _getLocation() async {
    try {
      // ignore: unused_local_variable
      var location = await _locationTracker.getLocation();

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newData) {
        if (mapController != null) {
          mapController.animateCamera(WEMAP.CameraUpdate.newCameraPosition(
              new WEMAP.CameraPosition(
                  bearing: 0.0,
                  target: WEMAP.LatLng(newData.latitude, newData.longitude),
                  tilt: 0,
                  zoom: 16.00)));
          mapController.addLine(WEMAP.LineOptions(
            lineColor: "#08a5bd",
            lineWidth: 5,
            lineOpacity: 1,
          ));
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WeMap Home',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[400],
        leading: Builder(
          builder: ( BuildContext context){
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: "Menu",
            );
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.yellow[300],),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "Notifications",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      elevation: 0.0,
                    ),
                    body: Center(
                      child: Text(
                        "No Notifications",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              ));
            },
            tooltip: "Notifications",
          ),
        ],
        elevation: 0.0,
        bottomOpacity: 0.5,
      ),

      body: WEMAP.WeMap(
        styleString: _styleString,
        initialCameraPosition: _initialLocation,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[400],
        onPressed: _getLocation,
        tooltip: 'getLocation',
        child: Icon(Icons.gps_fixed),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // ignore: missing_required_param
            DrawerHeader(
              //child: Text('WeMap Mobile'),
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover)
              ),
            ),
            ListTile(
              title: Text('Moblie Maps App'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: Text('Use WeMap-Flutter-SDK'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: Text('Made By Bui Quang Khai'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: Text('Version 1.0'),
              onTap: () {
                
              },
            ),
          ],
        ),
      )
    );
  }
}