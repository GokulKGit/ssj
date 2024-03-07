import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BackConfirmationPage(),
    );
  }
}

class BackConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back Confirmation'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // Show a dialog to confirm if the user wants to go back
          bool confirm = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirm'),
                content: Text('Do you want to go back?'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // Return false to prevent going back
                    },
                  ),
                  ElevatedButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(true); // Return true to allow going back
                    },
                  ),
                ],
              );
            },
          );
          return confirm ?? false; // Return false by default
        },
        child: Center(
          child: Text('Press back button to see the confirmation dialog'),
        ),
      ),
    );
  }
}
