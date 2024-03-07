import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gold Rate App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GoldRateScreen(),
    );
  }
}

class GoldRateScreen extends StatefulWidget {
  @override
  _GoldRateScreenState createState() => _GoldRateScreenState();
}

class _GoldRateScreenState extends State<GoldRateScreen> {
  // Function to fetch gold rate data
  Future<Map<String, dynamic>> fetchGoldRate() async {
    final response = await http.get(Uri.parse(
        'https://www.srishanmugajewellery.com/admin/public/api/goldrate/1'));

    if (response.statusCode == 200) {
      // If the server returns a successful response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load gold rate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gold Rate'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchGoldRate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while fetching data
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Display an error message if fetching data fails
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the fetched gold rate data
              final goldRate = snapshot.data!['goldRate'];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Gold Rate: ${goldRate['goldrate']}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
