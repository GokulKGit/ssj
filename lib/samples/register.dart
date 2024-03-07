// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:page_transition/page_transition.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sri_shanmuga_jewellery/API/api_handler.dart';
// import 'package:sri_shanmuga_jewellery/main.dart';
// import 'package:sri_shanmuga_jewellery/welcome_page/sign_in.dart';
// import 'package:sri_shanmuga_jewellery/welcome_page/signin_page/sign_in_page.dart';
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../share_preference.dart';

// class signupinput extends StatefulWidget {
//   const signupinput({Key? key}) : super(key: key);

//   @override
//   State<signupinput> createState() => _signupinputState();
// }

// class _signupinputState extends State<signupinput> {
//   //late DataModel _dataModel;

//   bool _passvisible = false;

//   TextEditingController usernameController = TextEditingController();
//   TextEditingController email_idController = TextEditingController();
//   TextEditingController date_of_birthController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController conform_passwordcontroller = TextEditingController();
//   TextEditingController mobile_numbercontroller = TextEditingController();

//   void updateStatus() {
//     setState(() {
//       _passvisible = !_passvisible;
//     });
//   }

//   Future<void> loginPostRequest() async {
//     const url = 'https://www.srishanmugajewellery.com/admin/public/api/userregister';
//     String name = usernameController.text;
//     String email = email_idController.text;
//     String password = passwordController.text;
//     String conformpassword = conform_passwordcontroller.text;
//     String dateofbirth = date_of_birthController.text;
//     String mobileno = mobile_numbercontroller.text;
//     Map<String, dynamic> requestBody = {
//       'user_name': name,
//       'email_id': email,
//       'password': password,
//       'conform_password': conformpassword,
//       'date_of_birth': dateofbirth,
//       'mobile_number': mobileno,
//     };
//     final response = await http.post(
//       Uri.parse(url),
//       body: requestBody,
//     );
//     print('vvvvvvv--------------------------');

//     print('${response.request?.url}');

//     print(response.statusCode);

//     if (response.statusCode == 201 || response.statusCode == 200) {
//       print('statues--------------------------');

//       final responseData = jsonDecode(response.body);
//       print(responseData);
//       var s = responseData['message'];
//       print('kavin----------------------------------------------');
//       print(s);
//       Fluttertoast.showToast(
//           msg: 'User registered successfully',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16.0);
//       // "message": "Data Found",
//       if (s == 'User registered successfully') {
//         print('just');
//         var res = responseData['user_id'];
//         print(res);

//         var id = res['user_id'];

//         UserPreferences.setLoggedIn(true);
//         UserPreferences.setUserId(id);

//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => signin()));
//         print('hgfjy');

//         print(id);
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setInt('user_id', id);
//         // print('kavin');
//         // print(id);
//         // final prefs = await SharedPreferences.getInstance();
//         // await prefs.setInt('user_id', id);
//       } else {
//         print("reg failed");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(10),
//           // decoration: BoxDecoration(
//           //   border: Border(
//           //     bottom: BorderSide(color: Colors.grey)
//           //   )
//           // ),

//           child: Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
//             child: TextFormField(
//               validator: (value) {
//                 if (value!.isEmpty ||
//                     !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
//                   return 'Please enter name';
//                 }
//                 return null;
//               },
//               keyboardType: TextInputType.text,
//               controller: usernameController,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   //borderSide:BorderSide(color: lightIconsColor),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 hintText: "User Name",
//                 label: Text(
//                   'User Name',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 fillColor: Color(0xFFF5F5F5),
//                 filled: true,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: TextFormField(
//             validator: (value) {
//               if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
//                 return 'Please enter email';
//               }
//               return null;
//             },
//             keyboardType: TextInputType.text,
//             controller: email_idController,
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 //borderSide:BorderSide(color: lightIconsColor),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               hintText: "Email",
//               label: Text(
//                 'Email',
//                 style: TextStyle(color: Colors.grey),
//               ),
//               fillColor: Color(0xFFF5F5F5),
//               filled: true,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: TextFormField(
//               validator: (value) {
//                 if (value!.isEmpty ||
//                     !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s./0-9]+$')
//                         .hasMatch(value!)) {
//                   return 'Please enter DOB';
//                 }
//                 return null;
//               },
//               keyboardType: TextInputType.none,
//               controller: date_of_birthController,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   //borderSide:BorderSide(color: lightIconsColor),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 hintText: 'Date of Birth',
//                 label: Text(
//                   'Date of Birth',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 suffixIcon: const Icon(
//                   Icons.date_range,
//                   color: Colors.grey,
//                 ),
//                 fillColor: Color(0xFFF5F5F5),
//                 filled: true,
//               ),
//               onTap: () async {
//                 DateTime? pickeddate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1980),
//                     lastDate: DateTime(2100));

//                 if (pickeddate != null && pickeddate != DateTime.now()) {
//                   setState(() {
//                     date_of_birthController.text = pickeddate.toString();
//                   });
//                 } else {
//                   print("Enter Your DOB");
//                 }
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: TextFormField(
//             validator: (value) {
//               if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
//                 return 'Please enter password';
//               }
//               return null;
//             },
//             obscureText: _passvisible ? false : true,
//             keyboardType: TextInputType.visiblePassword,
//             controller: passwordController,
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 //borderSide:BorderSide(color: lightIconsColor),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               hintText: "Password",
//               label: Text(
//                 'Password',
//                 style: TextStyle(color: Colors.grey),
//               ),
//               suffixIcon: IconButton(
//                 onPressed: () {
//                   updateStatus();
//                 },
//                 icon: Icon(
//                   _passvisible ? Icons.visibility : Icons.visibility_off,
//                 ),
//               ),
//               fillColor: Color(0xFFF5F5F5),
//               filled: true,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: TextFormField(
//             validator: (value) {
//               if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
//                 return 'Please enter password';
//               }
//               return null;
//             },
//             obscureText: _passvisible ? false : true,
//             keyboardType: TextInputType.visiblePassword,
//             controller: conform_passwordcontroller,
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 //borderSide:BorderSide(color: lightIconsColor),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               hintText: "Password",
//               label: Text(
//                 'Password',
//                 style: TextStyle(color: Colors.grey),
//               ),
//               suffixIcon: IconButton(
//                 onPressed: () {
//                   updateStatus();
//                 },
//                 icon: Icon(
//                   _passvisible ? Icons.visibility : Icons.visibility_off,
//                 ),
//               ),
//               fillColor: Color(0xFFF5F5F5),
//               filled: true,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//           child: TextFormField(
//             validator: (value) {
//               if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
//                 return 'Please enter confirm password';
//               }
//               return null;
//             },
//             keyboardType: TextInputType.text,
//             controller: mobile_numbercontroller,
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 //borderSide:BorderSide(color: lightIconsColor),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               hintText: "mobile no",
//               label: Text(
//                 'mobile no',
//                 style: TextStyle(color: Colors.grey),
//               ),
//               fillColor: Color(0xFFF5F5F5),
//               filled: true,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         GestureDetector(
//           onTap: () async {
//             loginPostRequest();
//           },
//           child: Container(
//             height: 50,
//             width: 180,
//             decoration: BoxDecoration(
//               color: Color(0xFFB71C1C),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Text(
//                 'Signup',
//                 style: (TextStyle(color: Colors.white)),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Center(
//           child: TextButton(
//             child: Text(
//               "Don't you have any Account? Sign in",
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => signinpage()),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }


// // UserPreferences.setLoggedIn(true);
// // UserPreferences.setUserId(id);