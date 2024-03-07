import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:ssj/shareprefernce/loginchecker.dart";

class Register {
  final String user_name;
  final int email_id;
  final String password;
  final String conform_password;
  final String date_of_birth;
  final String mobile_number;
  final String gender;

  const Register(
      {required this.user_name,
      required this.email_id,
      required this.password,
      required this.conform_password,
      required this.date_of_birth,
      required this.mobile_number,
      required this.gender});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      user_name: json['user_name'].toString(),
      email_id: json['email_id'] ?? 0,
      password: json['password'] ?? "",
      conform_password: json['conform_password'] ?? "",
      date_of_birth: json['date_of_birth'] ?? "",
      mobile_number: json['mobile_number'] ?? "",
      gender: json['gender'] ?? "",
    );
  }
}

Future<Register> createUser({
  required user_name,
  required email_id,
  required password,
  required conform_password,
  required date_of_birth,
  required mobile_number,
  required gender,
  required BuildContext ctx,
}) async {
  final response = await http.post(
    Uri.parse(""
        // https://www.srishanmugajewellery.com/admin/public/api/userregister
        ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'user_name': user_name.toString(),
        'email_id': email_id.toString(),
        'password': password.toString(),
        'conform_password': conform_password.toString(),
        'date_of_birth': date_of_birth.toString(),
        'mobile_number': mobile_number.toString(),
        'gender': gender.toString(),
        'fcm_token': "",
      },
    ),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    print(response.body);
    print("status Code  : ${response.statusCode}");

    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    String userId = responseBody["user_id"].toString();
    print("User ID: $userId");

    //User ID: 68

    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    UserPreferences.setLoggedIn(true);
    // UserPreferences.setUserId(userId);

    return Register.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
