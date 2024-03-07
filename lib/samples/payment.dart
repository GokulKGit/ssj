import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    YourWidget(),
  );
}

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  Future<String>? firstResponse;

  @override
  void initState() {
    super.initState();
    fetchFirstResponse();
  }

  Future<void> fetchFirstResponse() async {
    var url = Uri.parse(
        'https://www.srishanmugajewellery.com/admin/public/api/api/create-payment/1');

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
        var paymentId = jsonResponse['payment_id'].toString();
        setState(() {
          firstResponse = makePhonePePayment(paymentId);
        });

        print("Id da : ${makePhonePePayment(paymentId)}");
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<String> makePhonePePayment(String paymentId) async {
    var url = Uri.parse(
        'https://www.srishanmugajewellery.com/admin/public/api/api/make-phonepe-payment');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> requestBody = {
      'payment_id': paymentId,
    };

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var transactionId = jsonResponse['transaction_id'].toString();
        return transactionId;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
        return '';
      }
    } catch (e) {
      print('Exception occurred: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: firstResponse,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No transaction ID available.');
            } else {
              return Text('Transaction ID: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
