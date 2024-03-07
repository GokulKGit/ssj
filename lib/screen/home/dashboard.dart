import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssj/screen/home/dashboard_container.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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

  Future<Map<String, dynamic>> fetchSilverRate() async {
    final response = await http.get(Uri.parse(
        'https://www.srishanmugajewellery.com/admin/public/api/silverrate/1'));

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              elevation: 4,
              color: Color(0xff832729),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.white,
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("asset/gold.png"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("GOLD"),
                                    FutureBuilder<Map<String, dynamic>>(
                                      future: fetchGoldRate(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // Display a loading indicator while fetching data
                                          return Text("loading..");
                                        } else if (snapshot.hasError) {
                                          // Display an error message if fetching data fails
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          // Display the fetched gold rate data
                                          final goldRate =
                                              snapshot.data!['goldRate'];
                                          return Text(
                                            '${goldRate['goldrate']}',
                                            style: TextStyle(
                                                color: Color(0xff832729),
                                                fontWeight: FontWeight.bold),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          shadowColor: Colors.white,
                          elevation: 5,
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("asset/silver.png"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("SILVER"),
                                    FutureBuilder<Map<String, dynamic>>(
                                      future: fetchSilverRate(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // Display a loading indicator while fetching data
                                          return Text("loading..");
                                        } else if (snapshot.hasError) {
                                          // Display an error message if fetching data fails
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          // Display the fetched gold rate data
                                          final silverRate =
                                              snapshot.data!['silverrate'];
                                          return Text(
                                            '${silverRate['silverrate']}',
                                            style: TextStyle(
                                              color: Color(0xff832729),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Builder(builder: (context) {
              return Container(
                //height: 800,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: homescreeninput(),
              );
            }),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
