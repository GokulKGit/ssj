import 'dart:convert';

import 'package:http/http.dart' as http;

void updateFCMToken(String userId, String fcmToken) async {
  final String apiUrl =
      'https://www.srishanmugajewellery.com/admin/public/api/update-fcm-token/$userId';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> requestBody = {
    'fcm_token': fcmToken,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Successful request, you can handle the response here
      print('FCM Token updated successfully');
    } else {
      // Request failed, handle the error
      print('Failed to update FCM Token. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // An error occurred while making the request
    print('Error: $error');
  }
}
