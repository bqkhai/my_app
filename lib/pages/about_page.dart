import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/ePage.dart';



class AboutPage extends EPage {
  AboutPage() : super(const Icon(Icons.account_circle), 'About');

  @override
  Widget build(BuildContext context) {
    return const About();
  }
}

class About extends StatefulWidget {
  const About();

  @override
  State createState() => AboutStage();
}

class AboutStage extends State<About>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}