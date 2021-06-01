import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  static const String idScreen = 'profile';
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("users");

  User user;
  bool isSignedIn = false;
  bool isUserIdNull = true;
 
  getUser() async {
    User firebaseUser = await _auth.currentUser;
    await firebaseUser
        ?.reload();
    firebaseUser = await _auth.currentUser;
    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
        this.isUserIdNull = false;
      });
    }
  }

  Future<void> _logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, 
        MaterialPageRoute(builder: (context)=> LoginPage()),
      );
    } catch(e){
      print(e.toString());
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.grey[200],
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        height: 500.0,
        width: 500.0,
        child: new ListView(
          children: <Widget>[
            Image.asset(
              'assets/images/user.png',
              height: 200,
              width: 200,
              //fit: BoxFit.fitWidth,
            ),
            Container(
              child: Expanded(
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Bui Quang Khai'),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('khaibui2000uet@gmail.com'),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('0978308894'),
                ),
              ),   
            ),
            Container(
              
            ),
            // TextButton(
            //   onPressed: (){
            //     _logout();
            //   },
            //   child: Text(
            //     "Log out",
            //     style: TextStyle(
            //       fontSize: 22,
            //       color: Colors.green.shade400,
            //       backgroundColor: Colors.grey[200]
            //     ),
            //   ),
            // ),
            RaisedButton(
              color: Colors.green[300],
              textColor: Colors.black,
                child: Container(
                  // height: 40.0,
                  // width: 40.0,
                  
                  child: Center(
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              onPressed: () {
                _logout();
              },
            )
          ]
        ),
      ),   
    );
  }
}