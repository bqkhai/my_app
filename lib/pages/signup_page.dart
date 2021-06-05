import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/widgets/progressDialog.dart';
import 'package:my_app/pages/login_page.dart';


import '../main.dart';


// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  static const String idScreen = 'signup';

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering, please wait...",
          );
        });
    final firebaseUser = (await _auth
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: errMsg);
    }))
        .user;
    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid);
      Map userDataMap = {
        'name': name.text.trim(),
        'email': email.text.trim(),
        'phone': phone.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);
      Fluttertoast.showToast(msg: 'Sign up successful');
      Navigator.pushNamed(context, LoginPage.idScreen);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Sign up failed");
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
                'Đăng ký tài khoản',
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
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
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
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.green[300],
                      textColor: Colors.black,
                      child: Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            'Submit',
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
                        if (name.text.length < 4) {
                          Fluttertoast.showToast(msg: 'full name');
                        } else if (!email.text.contains('@')) {
                          Fluttertoast.showToast(msg: 'email invalid');
                        } else if (phone.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'phone number is required');
                        } else if (password.text.length < 6) {
                          Fluttertoast.showToast(
                              msg: 'password must be 6 or more characters');
                        } else {
                          registerNewUser(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text(
                  'Already have an account? Log in',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.idScreen, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}