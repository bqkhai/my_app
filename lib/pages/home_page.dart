import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;
import 'package:flutter/services.dart';
import 'package:location/location.dart';




class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  static const String id = 'home';

  final String title;

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  WEMAP.WeMapController mapController;
  String styleString = WEMAP.WeMapStyles.WEMAP_VECTOR_STYLE;
  StreamSubscription locationSubscription;
  Location locationTracker = Location();

  WEMAP.CameraPosition initialLocation = WEMAP.CameraPosition(
      target: WEMAP.LatLng(21.059686, 105.779383), zoom: 16.00);



  void _onMapCreated(WEMAP.WeMapController controller) async {
    mapController = controller;
  }


  void _getLocation() async {
    try {
      // ignore: unused_local_variable
      var location = await locationTracker.getLocation();

      if (locationSubscription != null) {
        locationSubscription.cancel();
      }

      locationSubscription = locationTracker.onLocationChanged.listen((newData) {
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
    if (locationSubscription != null) {
      locationSubscription.cancel();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: WEMAP.WeMap(
        styleString: styleString,
        initialCameraPosition: initialLocation,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        tooltip: 'getLocation',
        child: Icon(Icons.my_location),
      ),
    );
  }
}