import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssj/api/get/goldschemedata.dart';
import 'package:ssj/screen/home/joinScheme/scheme_detail.dart';
import 'package:ssj/util/constant.dart';
import 'package:http/http.dart' as http;
import 'package:ssj/util/containerBox.dart';

// class JoinSchemeScreen extends StatefulWidget {
//   const JoinSchemeScreen({super.key});

//   @override
//   State<JoinSchemeScreen> createState() => _JoinSchemeScreenState();
// }

// class _JoinSchemeScreenState extends State<JoinSchemeScreen> {
//   late Future<GoldSchemeData> _goldSchemes;

//   @override
//   void initState() {
//     super.initState();
//     _goldSchemes = fetchGoldScheme();
//   }

// //ENGLISH
//   Future<GoldSchemeData> fetchGoldScheme() async {
//     final response = await http.get(Uri.parse(
//         '$BASEURL/public/api/goldschemes')); // Replace with your API endpoint
//     if (response.statusCode == 200) {
//       print("Response" + response.body);
//       return GoldSchemeData.fromJson(
//         jsonDecode(
//           response.body,
//         ),
//       );
//     } else {
//       throw Exception('Failed to load brochure');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder<GoldSchemeData>(
//       future: _goldSchemes,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.hasData) {
//           final brochure = snapshot.data;
//           return Padding(
//             padding:
//                 const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
//             child: ListView.builder(
//                 itemCount: brochure?.data.length ?? 0,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     child: Column(children: [
//                       Text(
//                         snapshot.data!.data[index].schemeTitle,
//                       ),
//                     ]),
//                   );
//                 }),
//           );
//         } else {
//           return Center(child: Text('No data available.'));
//         }
//       },
//     ));
//   }
// }

class GoldSchemesWidget extends StatefulWidget {
  @override
  _GoldSchemesWidgetState createState() => _GoldSchemesWidgetState();
}

class _GoldSchemesWidgetState extends State<GoldSchemesWidget> {
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
        elevation: 0,
        title: Text('Gold Schemes'),
      ),
      body: FutureBuilder<GoldSchemes>(
        future: _goldSchemes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final goldSchemes = snapshot.data;
            return Center(
              child: ListView.builder(
                itemCount: goldSchemes!.data.length,
                itemBuilder: (context, index) {
                  final item = goldSchemes.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          child: GestureDetector(
                            onTap: () {
                              print("INdex ::::: ${item.id}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      sehemedetailsscreeninput(
                                    // id: item.id,
                                    id: index,
                                    SchemeId: item.id,
                                    SchemeName: item.schemeTitle,
                                  ),
                                ),
                              );
                            },
                            child: InkWell(
                              child: Container(
                                height: 230,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.schemeTitle,
                                        style: TextStyle(
                                            overflow: TextOverflow.clip,
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[800],
                                    image: DecorationImage(
                                        opacity: 90,
                                        image:
                                            NetworkImage(item.bannerImageUrl),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
