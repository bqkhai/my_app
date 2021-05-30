import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/components/bottomNavBar.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/widgets/progressDialog.dart';
import 'package:my_app/pages/signup_page.dart';


import '../main.dart';


class LoginPage extends StatefulWidget {
  static const String idScreen = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginAuth(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Đang xác thực, vui lòng chờ...",
          );
        });
    final firebaseUser = (await _auth
            .signInWithEmailAndPassword(
                email: email.text, password: password.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: errMsg);
    }))
        .user;
    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamed(context, BottomNavBar.idScreen);
          Fluttertoast.showToast(msg: 'Đăng nhập thành công');
        } else {
          Navigator.pop(context);

          _auth.signOut();
          Fluttertoast.showToast(msg: 'Tài khoản không tồn tại');
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Không thể đăng nhập");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage("assets/images/logo.png"),
                width: 390.0,
                height: 200.0,
              ),
              SizedBox(height: 1.0),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      color: Colors.green[300],
                      textColor: Colors.black,
                      child: Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            'submit',
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
                        loginAuth(context);
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                child: Text(
                  'Don''t have account. Sign up here',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignUpPage.idScreen, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}