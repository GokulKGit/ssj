import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ssj/api/firebase/firebase_notification.dart';
import 'package:ssj/main.dart';
import 'package:ssj/screen/login/login.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';

class SplashScreen extends StatefulWidget {
  final FirebaseNotification firebaseNotification;

  SplashScreen({required this.firebaseNotification});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String? fcmToken;
  @override
  void initState() {
    super.initState();
    fcmToken = widget.firebaseNotification.fcmToken;
    UserPreferences.setFcmToken(fcmToken.toString());

    Timer(
      Duration(seconds: 10),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserPreferences.isLoggedIn() ? BottomNavBar() : signininput(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xff832729),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: Color(0xff832729),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  )),
            ),
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/logo.png'),
                  // Replace with your image file path
                  fit: BoxFit
                      .cover, // You can adjust the fit based on your requirements
                ),
              ),
            ),
          ),
          // Text(
          //   "$fcmToken",
          //   style: TextStyle(fontSize: 10),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Text("new :)"),
          // Text(
          //   "new : ${UserPreferences.getFcmToken()}",
          //   style: TextStyle(fontSize: 10),
          // ),
        ],
      ),
    );
  }
}
