import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ssj/api/get/getbrochure.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:ssj/util/constant.dart';
import 'package:ssj/util/containerBox.dart';

class PdfViewerScreen extends StatefulWidget {
  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late Future<Brochure> _brochureEnglish;
  Future<Brochure>? _brochureTamil;

  String userId = UserPreferences.getUserId();

  @override
  void initState() {
    super.initState();
    _brochureEnglish = fetchBrochureEnglish();
    _brochureTamil = fetchBrochureTamil();
  }

//ENGLISH
  Future<Brochure> fetchBrochureEnglish() async {
    final response = await http.get(Uri.parse(
        '$BASEURL/public/api/getpdf/1')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      print("Response" + response.body);
      return Brochure.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Exception('Failed to load brochure');
    }
  }

//TAMIL
  Future<Brochure> fetchBrochureTamil() async {
    final response = await http.get(Uri.parse(
        '$BASEURL/public/api/getpdf/0')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      print("Response" + response.body);
      return Brochure.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Exception('Failed to load brochure');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Brochures"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white, //<-- selected text color
              unselectedLabelColor: Colors.grey[400], //
              isScrollable: false,
              tabs: const <Widget>[
                Tab(
                  text: "English",
                ),
                Tab(
                  text: "Tamil",
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              FutureBuilder<Brochure>(
                future: _brochureEnglish,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No Brochures Added Yet'));
                  } else if (snapshot.hasData) {
                    final brochure = snapshot.data;
                    return TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 30, left: 30, bottom: 10),
                            child: GridView.builder(
                                itemCount: brochure?.response.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 40,
                                  childAspectRatio: 0.7,
                                ),
                                itemBuilder: (context, index) {
                                  final location =
                                      snapshot.data!.response[index].location;
                                  final name =
                                      snapshot.data!.response[index].name;
                                  return ContainerGrid(
                                    name: name,
                                    location: location,
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 30, left: 30, bottom: 10),
                            child: GridView.builder(
                                itemCount: brochure?.response.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 40,
                                  childAspectRatio: 0.7,
                                ),
                                itemBuilder: (context, index) {
                                  final location =
                                      snapshot.data!.response[index].location;
                                  final name =
                                      snapshot.data!.response[index].name;
                                  return ContainerGrid(
                                    name: name,
                                    location: location,
                                  );
                                }),
                          ),
                        ]);
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
              FutureBuilder<Brochure>(
                future: _brochureTamil,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No Brochures Added Yet'));
                  } else if (snapshot.hasData) {
                    final brochure = snapshot.data;
                    return TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 30, left: 30, bottom: 10),
                            child: GridView.builder(
                                itemCount: brochure?.response.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 40,
                                  childAspectRatio: 0.7,
                                ),
                                itemBuilder: (context, index) {
                                  final location =
                                      snapshot.data!.response[index].location;
                                  final name =
                                      snapshot.data!.response[index].name;
                                  return ContainerGrid(
                                    name: name,
                                    location: location,
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 30, left: 30, bottom: 10),
                            child: GridView.builder(
                                itemCount: brochure?.response.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 40,
                                  childAspectRatio: 0.7,
                                ),
                                itemBuilder: (context, index) {
                                  final location =
                                      snapshot.data!.response[index].location;
                                  final name =
                                      snapshot.data!.response[index].name;
                                  return ContainerGrid(
                                    name: name,
                                    location: location,
                                  );
                                }),
                          ),
                        ]);
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
            ],
          )),
    );
  }
}
