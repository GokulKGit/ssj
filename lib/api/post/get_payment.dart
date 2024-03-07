import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> fetchPaymentResponse(String SchemeId) async {
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
