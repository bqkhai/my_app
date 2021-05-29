import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';

import 'ePage.dart';

class RoutePage extends EPage {
  RoutePage() : super(const Icon(Icons.directions), 'Go');

  @override
  Widget build(BuildContext context) {
    return const Routing();
  }
}

class Routing extends StatefulWidget {
  const Routing();

  @override
  State createState() => RoutingState();
}

class RoutingState extends State<Routing> {
  final WeMapPlace _originPlace = null;
  final WeMapPlace _destinationPlace = null;
  
  @override
  Widget build(BuildContext context) {
    return WeMapDirection(
      originIcon: "assets/symbols/origin.png", 
      destinationIcon: "assets/symbols/destination.png",
      originPlace: _originPlace,
      destinationPlace: _destinationPlace,
    );
  }
}