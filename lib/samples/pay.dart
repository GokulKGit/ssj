import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Payment API Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await makePayment();
            },
            child: Text('Make Payment'),
          ),
        ),
      ),
    );
  }

  Future makePayment() async {
    // Replace this URL with your actual payment API endpoint
    String apiUrl =
        'https://www.srishanmugajewellery.com/admin/public/api/api/make-phonepe-payment';

    // Replace this payment ID with the actual payment ID you want to pass
    int paymentId = 175;

    // Create the JSON body
    Map<String, dynamic> requestBody = {
      'payment_id': paymentId,
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
}
