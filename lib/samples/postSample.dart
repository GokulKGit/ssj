// import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:ssj/screen/home/dashboard.dart';
// // import 'package:ssj/shareprefernce/loginchecker.dart';

// // class LoginUser {
// //   final String email;
// //   final String password;

// //   LoginUser({required this.email, required this.password});

// //   factory LoginUser.fromJson(Map<String, dynamic> json) {
// //     return LoginUser(
// //       email: json['email'],
// //       password: json['password'],
// //     );
// //   }
// // }

// // Future<LoginUser> userLoginToDashboard(
// //     BuildContext context, String email, String password) async {
// //   final response = await http.post(
// //     Uri.parse('https://www.srishanmugajewellery.com/admin/public/api/signin'),
// //     headers: <String, String>{
// //       'Content-Type': 'application/json; charset=UTF-8',
// //     },
// //     body: jsonEncode(<String, dynamic>{
// //       'email_id': email,
// //       'password': password,
// //     }),
// //   );

// //   if (response.statusCode == 201 || response.statusCode == 200) {
// //     var responseData = jsonDecode(response.body);
// //     var data = responseData['data'];
// //     // var userId =
// //     //     data['id'].toString(); // Make sure to convert the ID to a String
// //     // UserPreferences.setUserId(userId);

// //     // You should use Navigator.of(context) to access the navigator
// //     Navigator.of(context)
// //         .push(MaterialPageRoute(builder: (context) => homescreen()));

// //     return LoginUser.fromJson(data);
// //   } else {
// //     // If the server did not return a 201 CREATED response,
// //     // then throw an exception.
// //     throw Exception('Failed to login user.');
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:ssj/shareprefernce/loginchecker.dart';

// class LoginUser {
//   final String email;
//   final String password;

//   LoginUser({required this.email, required this.password});

//   factory LoginUser.fromJson(Map<String, dynamic> json) {
//     return LoginUser(
//       email: json['email_id'],
//       password: json['password'],
//     );
//   }
// }

// class YourLoginScreen extends StatefulWidget {
//   @override
//   _YourLoginScreenState createState() => _YourLoginScreenState();
// }

// class _YourLoginScreenState extends State<YourLoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<LoginUser> userLoginToDashboard(
//       BuildContext context, String email, String password) async {
//     final response = await http.post(
//       Uri.parse('https://www.srishanmugajewellery.com/admin/public/api/signin'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'email_id': email,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 201 || response.statusCode == 200) {
//       var responseData = jsonDecode(response.body);
//       var data = responseData['data'];
//       var userId = data['id'].toString();
//       var userName = data['user_name'].toString();

//       UserPreferences.setUserId(userId);
//       UserPreferences.setUserName(userName);
//       UserPreferences.setLoggedIn(true);

//       Fluttertoast.showToast(
//         msg: 'Login Successful',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         ),
//       );

//       return LoginUser.fromJson(data);
//     } else {
//       Fluttertoast.showToast(
//         msg: 'Invalid Email or Password',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       throw Exception('Failed to login user.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 String email = emailController.text;
//                 String password = passwordController.text;
//                 userLoginToDashboard(context, email, password);
//               },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Home Screen!'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: YourLoginScreen(),
//   ));
// }
