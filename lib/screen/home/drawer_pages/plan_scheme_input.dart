import 'package:flutter/material.dart';
import 'package:ssj/screen/home/dashboard.dart';
import 'package:ssj/screen/home/joinScheme/goldscheme.dart';

class planschemeinput extends StatelessWidget {
  const planschemeinput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: Image(
            height: 200,
            width: 350,
            image: AssetImage(
              "assets/jewelbanner.webp",
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          width: 280,
          child: TextButton(
            style: TextButton.styleFrom(
              // primary: Colors.purpleAccent,
              backgroundColor: Color(0xff832729),
              // Background Color
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyHomePage()),
              // );
            },
            child: Text(
              "Join Scheme",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Image(
            height: 200,
            width: 350,
            image: AssetImage(
              "assets/silver.jpeg",
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          width: 280,
          child: TextButton(
            style: TextButton.styleFrom(
              // primary: Colors.purpleAccent,
              backgroundColor: Color(0xff832729),
              // Background Color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homescreen()), //TODO
              );
            },
            child: Text(
              "Join Scheme",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
