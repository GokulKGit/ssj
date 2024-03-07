import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ssj/api/get/payment_history_scheme.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:ssj/util/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../paymethod.dart';

class HistoryOfMyScheme extends StatefulWidget {
  HistoryOfMyScheme({
    required this.schemeId,
    required this.schemeName,
  });
  String schemeId = "";
  String schemeName = "";
  @override
  State<HistoryOfMyScheme> createState() => _HistoryOfMySchemeState();
}

class _HistoryOfMySchemeState extends State<HistoryOfMyScheme> {
  Future<PaymentHistoryOfScheme>? fetchSchemeHistory;

  String userName = UserPreferences.getUserName();
  String userId = UserPreferences.getUserId();

  Future<PaymentHistoryOfScheme> fetchUserSchemeHistory() async {
    try {
      final response = await http.get(
          Uri.parse('$BASEURL/public/api/paymenthistory/${widget.schemeId}'));

      if (response.statusCode == 200) {
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

  var fetchedPaymentId; // State variable to store payment ID

  @override
  void initState() {
    super.initState();
    fetchSchemeHistory = fetchUserSchemeHistory();
  }

  fetchPaymentResponse(String SchemeId) async {
    var url = Uri.parse(
        'https://srishanmugajewellery.com/admin/public/api/api/create-payment/$SchemeId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> requestBody = {
      // Add your request parameters here if needed
    };

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var paymentId = jsonResponse['payment_id'];
        print('Response: $paymentId');
        setState(() {
          fetchedPaymentId = paymentId.toString();
        });
        return paymentId; // Return the payment ID
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
        return null; // Return null if the request fails
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null; // Return null in case of exceptions
    }
  }

  Future makePayment(int PaymentId) async {
    // Replace this URL with your actual payment API endpoint
    String apiUrl =
        'https://www.srishanmugajewellery.com/admin/public/api/api/make-phonepe-payment';

    // Replace this payment ID with the actual payment ID you want to pass
    int myId = PaymentId;

    // Create the JSON body
    Map<String, dynamic> requestBody = {
      'payment_id': myId,
    };

    // Convert the body to JSON
    String requestBodyJson = jsonEncode(requestBody);

    // Make the POST request
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        // Parse HTML response to extract the redirect URL

        print(response.statusCode);
        print(response.body);

        // Decode the JSON response
        Map<String, dynamic> decodedResponse = json.decode(response.body);

        // Extract the URL from the decoded response
        String url = decodedResponse['url'];

        // Replace "\/" with "/"
        String modifiedUrl = url.replaceAll(r"\/", "/");

        // Launch the URL in a web browser

        try {
          if (await canLaunchUrl(Uri.parse(modifiedUrl))) {
            await launchUrl(
              Uri.parse(modifiedUrl),
              mode: LaunchMode.inAppBrowserView,
            );
          } else {
            throw 'Could not launch $url';
          }
        } catch (e) {
          print('Error launching URL: $e');
        }
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Handle network errors
      print('Network error: $e');
    }
  }
  //
  // Future<void> makePayment(int paymentId) async {
  //   // Replace this URL with your actual payment API endpoint
  //   String apiUrl =
  //       'https://www.srishanmugajewellery.com/admin/public/api/api/make-phonepe-payment';
  //
  //   // Replace this payment ID with the actual payment ID you want to pass
  //   int myId = paymentId;
  //
  //   // Create the JSON body
  //   Map<String, dynamic> requestBody = {
  //     'payment_id': myId,
  //   };
  //
  //   // Convert the body to JSON
  //   String requestBodyJson = jsonEncode(requestBody);
  //
  //   // Make the POST request
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: requestBodyJson,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Decode the JSON response
  //       Map<String, dynamic> decodedResponse = json.decode(response.body);
  //
  //       // Extract the URL from the decoded response
  //       String url = decodedResponse['url'];
  //
  //       // Replace "\/" with "/"
  //       String modifiedUrl = url.replaceAll(r"\/", "/");
  //
  //       // Open the payment web view
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PaymentWebView(apiUrl: modifiedUrl),
  //         ),
  //       );
  //     } else {
  //       // Handle errors
  //       print('Error: ${response.statusCode}');
  //       print('Response: ${response.body}');
  //     }
  //   } catch (e) {
  //     // Handle network errors
  //     print('Network error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Theme(
          data: Theme.of(context).copyWith(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  extendedSizeConstraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50))),
          child: FloatingActionButton.extended(
            backgroundColor: BASECOLOR,
            onPressed: () async {
              Fluttertoast.showToast(
                msg: "Preoceesing...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              await fetchPaymentResponse(widget.schemeId);

              await makePayment(int.parse(fetchedPaymentId.toString()));
            },
            label: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Pay Now",
                style: TextStyle(fontWeight: FontWeight.bold, color: FONTCOLOR),
              ),
            ),
          )),
      appBar: AppBar(title: Text("History")),
      body: FutureBuilder<PaymentHistoryOfScheme>(
        future: fetchSchemeHistory, // Use the initialized future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.hasError.toString()));
          } else if (snapshot.data == null) {
            return Center(
                child: Text("Pay First payment for activate the plan"));
          } else {
            final paymentHistory = snapshot.data!;

            // Data is successfully loaded

            int months = paymentHistory.payments.length;
            print(months);

            double sumSchemeAmount = paymentHistory.payments
                .map((payment) => double.parse(payment.schemeAmount))
                .fold(0, (previousValue, element) => previousValue + element);

            double sumTotalGram = paymentHistory.payments
                .map((payment) => double.parse(payment.goldGram))
                .fold(0, (previousValue, element) => previousValue + element);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text("${widget.schemeName}"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 10,
                              child: Container(
                                height: 70,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Total Amount"),
                                        Text(
                                          "\u20b9 $sumSchemeAmount",
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
                          Expanded(
                            child: Card(
                              elevation: 10,
                              child: Container(
                                height: 70,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Total Grams"),
                                        Text(
                                          "${double.parse(sumTotalGram.toString()).toStringAsFixed(4)} gm",
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
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.020,
                            ),
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.020,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Branch",
                            style: TextStyle(
                              color: BASECOLOR,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.020,
                            ),
                          ),
                          Text(
                            "Salem",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.020,
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
                            "$months / 11 Month",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.016,
                            ),
                          ),
                          Text(
                            "No Due",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.016,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: Text("Transcation History"),
                      leading: Icon(
                        Icons.payment_outlined,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
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
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.016,
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
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.016,
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
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.016,
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
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.016,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                    // Dynamically build rows based on the data
                    for (var payment in paymentHistory.payments)
                      Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${payment.paymentDate.toString().length > 10 ? payment.paymentDate.toString().substring(0, 10) : ""}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.016,
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
                                            0.016,
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
                                            0.016,
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
                                            0.016,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),

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
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
