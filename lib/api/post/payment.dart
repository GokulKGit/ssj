import 'dart:convert';

import 'package:http/http.dart' as http;

class PostPayment {
  final String scheme_id;
  final String master_id;
  final String gold_gram;
  final String goldrate;
  final String scheme_title;
  final String payment_mode;
  final String scheme_amount;
  final String usermanagement_id;

  PostPayment({
    required this.scheme_id,
    required this.master_id,
    required this.gold_gram,
    required this.goldrate,
    required this.scheme_title,
    required this.payment_mode,
    required this.scheme_amount,
    required this.usermanagement_id,
  });

  factory PostPayment.fromJson(Map<String, dynamic> json) {
    return PostPayment(
      scheme_id: json['scheme_id'],
      master_id: json['master_id'],
      gold_gram: json['gold_gram'],
      goldrate: json['goldrate'],
      scheme_title: json['scheme_title'],
      payment_mode: json['payment_mode'],
      scheme_amount: json['scheme_amount'],
      usermanagement_id: json['usermanagement_id'],
    );
  }
}

Future<PostPayment> createPayment(
    String scheme_id,
    String master_id,
    String gold_gram,
    String goldrate,
    String scheme_title,
    String payment_mode,
    String scheme_amount,
    String usermanagement_id) async {
  Map<String, dynamic> request = {
    'scheme_id': scheme_id,
    'master_id': master_id,
    'gold_gram': gold_gram,
    'goldrate': goldrate,
    'scheme_title': scheme_title,
    'payment_mode': payment_mode,
    'scheme_amount': scheme_amount,
    'usermanagement_id': usermanagement_id
  };

  final uri = Uri.parse(
      "https://www.srishanmugajewellery.com/admin/public/api/storepayment");
  final response = await http.post(uri, body: request);

  print('Request: $request');
  print('Response status code: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 201) {
    final decodedResponse = json.decode(response.body);
    return PostPayment.fromJson(decodedResponse);
  } else {
    throw Exception(
        "Failed to create payment. Status code: ${response.statusCode}");
  }
}
