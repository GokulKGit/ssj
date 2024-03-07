import 'package:flutter/material.dart';
import 'package:ssj/util/sendmailer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Email Sender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Send Welcome Email'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              sendMail(subject: "Hello");
            },
            child: Text('Send Welcome Email'),
          ),
        ),
      ),
    );
  }
}
