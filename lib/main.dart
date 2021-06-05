import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/bottomNavBar.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/signup_page.dart';
import 'package:my_app/shared/constants.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;


void main() async {
  WEMAP.Configuration.setWeMapKey(apiMapKey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child('users');


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile WeMap',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: LoginPage.idScreen,
      routes: {
        SignUpPage.idScreen: (context) => SignUpPage(),
        LoginPage.idScreen: (context) => LoginPage(),
        ProfilePage.idScreen: (context) => ProfilePage(),
        BottomNavBar.idScreen: (context) => BottomNavBar(0),
      },
    );
  }
}