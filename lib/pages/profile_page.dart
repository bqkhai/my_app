import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/ePage.dart';



class ProfilePage extends EPage {
  static const String idScreen = 'profile';
  ProfilePage() : super(const Icon(Icons.account_circle), 'Profile');
  @override
  Widget build(BuildContext context) {
    return const Profile();
  }
}

class Profile extends StatefulWidget {
  const Profile();

  @override
  State createState() => ProfileState();
}

class ProfileState extends State<Profile>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        
      ),
    );
  }
}