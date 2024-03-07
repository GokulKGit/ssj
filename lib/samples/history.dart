import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:ssj/api/get/payment_history_scheme.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:ssj/util/constant.dart';
import 'package:http/http.dart' as http;

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  //String userId = UserPreferences.getUserId();

  Future<PaymentHistoryOfScheme>? fetchSchemeHistory;

  Future<PaymentHistoryOfScheme> fetchUserSchemeHistory() async {
    try {
      final response =
          await http.get(Uri.parse('$BASEURL/public/api/paymenthistory/13'));

      if (response.statusCode == 200) {
        // Print the response body for debugging
        print('Response Body: ${response.body}');

        return PaymentHistoryOfScheme.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Print any error for debugging
      print('Error: $error');
      throw Exception('Failed to load data. Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSchemeHistory = fetchUserSchemeHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History of Transcation'),
      ),
      body: FutureBuilder<PaymentHistoryOfScheme>(
        future: fetchSchemeHistory, // Use the initialized future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.payments.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            // Data is successfully loaded
            final paymentHistory = snapshot.data!;
            return Column(
              children: [
                Text("Scheme Name"),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    size: 35,
                                    Icons.account_balance_wallet,
                                    color: BASECOLOR,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Total Amount"),
                                    Text(
                                      "\u20b9 0.00",
                                      style: TextStyle(
                                          color: Color(0xff832729),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.monitor_weight,
                                      size: 35,
                                      color: BASECOLOR,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Total Grams"),
                                    Text(
                                      "0.00 gm",
                                      style: TextStyle(
                                          color: Color(0xff832729),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          color: BASECOLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                      Text(
                        "Customer Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Branch",
                        style: TextStyle(
                          color: BASECOLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                      Text(
                        "Salem",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "10 / 11 Month",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                      Text(
                        "No Due",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: BASECOLOR),
                      children: [
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Date",
                            style: TextStyle(
                              color: FONTCOLOR,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Rate",
                            style: TextStyle(
                              color: FONTCOLOR,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Amount",
                            style: TextStyle(
                              color: FONTCOLOR,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Weight",
                            style: TextStyle(
                              color: FONTCOLOR,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: paymentHistory.payments.length,
                    itemBuilder: (context, index) {
                      final payment = paymentHistory.payments[index];
                      return Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${payment.paymentDate.toString().substring(0, 10)}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023,
                                  ),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${double.parse(payment.goldrate.toString()).toStringAsFixed(3)}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${payment.schemeAmount.toString()}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${double.parse(payment.goldGram.toString()).toStringAsFixed(3)}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ],
                      );

                      // ListTile(
                      //   title: Text(payment.schemeTitle),
                      //   subtitle: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //           'Payment Date: ${payment.paymentDate.toString()}'),
                      //       Text('goldGram: ${payment.goldGram.toString()}'),
                      //       Text(
                      //           'Scheme Amount: ${payment.schemeAmount.toString()}'),
                      //       Text('Gold rate: ${payment.goldrate.toString()}'),
                      //       Text('Pay_Mode: ${payment.paymentMode.toString()}'),
                      //       Text('Pay Date: ${payment.paymentDate.toString()}'),
                      //     ],
                      //   ),
                      //   // Add more fields as needed
                      // );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: YourWidget(),
  ));
}
