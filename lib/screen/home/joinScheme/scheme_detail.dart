import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_loading_button/progress_loading_button.dart';
import 'package:ssj/api/get/goldschemedata.dart';
import 'package:ssj/screen/home/joinScheme/scheme_register/schemeregister.dart';
import 'package:ssj/util/constant.dart';
import 'package:http/http.dart' as http;

class sehemedetailsscreeninput extends StatefulWidget {
  sehemedetailsscreeninput(
      {required this.id,
      required this.SchemeName,
      required this.SchemeId,
      Key? key})
      : super(key: key);

  int id, SchemeId;
  String SchemeName;

  @override
  State<sehemedetailsscreeninput> createState() =>
      _sehemedetailsscreeninputState();
}

class _sehemedetailsscreeninputState extends State<sehemedetailsscreeninput> {
  late Future<GoldSchemes> _goldSchemes;

  Future<GoldSchemes> fetchGoldScheme() async {
    final response =
        await http.get(Uri.parse('$BASEURL/public/api/goldschemes'));

    if (response.statusCode == 200) {
      return GoldSchemes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _goldSchemes = fetchGoldScheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff832729),
        title: Text(
          widget.SchemeName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<GoldSchemes>(
          future: _goldSchemes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else if (snapshot.hasData) {
              final goldSchemes = snapshot.data;
              return Center(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final item = goldSchemes!.data[widget.id];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                              image: DecorationImage(
                                image: NetworkImage(item.bannerImageUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            top: 8,
                          ),
                          child: Text(
                            "Scheme Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff832729)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.schemeTitle),
                        ),
                        Divider(
                          indent: 40,
                          endIndent: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "Duration",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff832729)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Start Date  -  ${item.startDate}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("End Date    -  ${item.endDate}"),
                        ),
                        Divider(
                          indent: 40,
                          endIndent: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "Benefits",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff832729)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            item.addBenifit,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Tier",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff832729)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "${item.tier}",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Age Limit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff832729)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "${item.agelimit}",
                          ),
                        ),
                        Divider(
                          indent: 40,
                          endIndent: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff832729)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            """${item.description}""",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.purpleAccent,
                              backgroundColor: Color(0xff832729),
                              // Background Color
                            ),
                            onPressed: () {
                              print(widget.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => schemescreen(
                                    masterId: MASTERID,
                                    listId: widget.id,
                                    schemeId: widget.SchemeId,
                                    schemeName: item.schemeTitle.toString(),
                                  ),
                                ),
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
                          height: 40,
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}
