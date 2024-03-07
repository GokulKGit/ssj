import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ssj/api/get/myschemedata.dart';
import 'package:ssj/screen/home/myschemes/history.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';

class MySchemeDataWidget extends StatefulWidget {
  @override
  _MySchemeDataWidgetState createState() => _MySchemeDataWidgetState();
}

class _MySchemeDataWidgetState extends State<MySchemeDataWidget> {
  late Future<MySchemeData> futureData;

  String UserId = UserPreferences.getUserId();

  Future<MySchemeData> fetchMySchemeData() async {
    final response = await http.get(Uri.parse(
        'https://www.srishanmugajewellery.com/admin/public/api/showuserscheme/$UserId'));

    if (response.statusCode == 200) {
      return MySchemeData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchMySchemeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Schemes'),
      ),
      body: Center(
        child: FutureBuilder<MySchemeData>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'No Scheme added yet',
                ),
              );
            } else if (snapshot.hasData) {
              final mySchemeData = snapshot.data;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: mySchemeData!.jointSchemes.length,
                      itemBuilder: (context, index) {
                        final jointScheme = mySchemeData.jointSchemes[index];
                        return Card(
                          color: Colors.white,
                          elevation: 3,
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Scheme Name",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  jointScheme.schemeTitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff832729)),
                                ),
                                Text(
                                  "Monthly : \u20B9 ${jointScheme.schemeAmount}",
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                jointScheme.status.contains("Pending")
                                    ? TextButton(
                                        child: Text(
                                          "Pending...",
                                          style: TextStyle(
                                              color: Color(0xff832729)),
                                        ),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Color(0xffffffff)),
                                        onPressed: () {
                                          Fluttertoast.showToast(
                                            msg: "KYC status pending",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        },
                                      )
                                    : TextButton(
                                        child: Text(
                                          "Pay Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Color(0xff832729)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryOfMyScheme(
                                                schemeId:
                                                    jointScheme.id.toString(),
                                                schemeName:
                                                    jointScheme.schemeTitle,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                // TextButton(
                                //   style: TextButton.styleFrom(
                                //       backgroundColor: Color(0xff832729)),
                                //   onPressed: () {
                                //     dynamic payId =
                                //         fetchPaymentResponse(UserId);
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => HistoryOfMyScheme(
                                //           schemeId: jointScheme.id.toString(),
                                //           schemeName: jointScheme.schemeTitle,
                                //           paymentId: payId,
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   child: Text(
                                //     "Pay Now",
                                //     style: TextStyle(color: Colors.white),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'No Scheme added yet',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
