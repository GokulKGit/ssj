import 'package:flutter/material.dart';

class popupinput extends StatelessWidget {
  const popupinput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: Image(
            height: 100,
            width: 100,
            image: AssetImage("asset/logo.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
          child: Text(
            'Do you want to complete this   Registration ?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 40,
              width: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.purpleAccent,
                  backgroundColor: Colors.black12,
                  // Background Color
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ),
                  // );
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.purpleAccent,
                  backgroundColor: Colors.black12,
                  // Background Color
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ),
                  // );
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
