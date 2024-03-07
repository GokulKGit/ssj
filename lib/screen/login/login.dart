import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ssj/api/post/login.dart';
import 'package:ssj/api/post/post_fcm_token.dart';
import 'package:ssj/main.dart';
import 'package:ssj/screen/login/forgetpassword.dart';
import 'package:ssj/screen/register/register.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';

class signininput extends StatefulWidget {
  @override
  State<signininput> createState() => _signininputState();
}

class _signininputState extends State<signininput> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool _passvisible = false;

  void updateStatus() {
    setState(() {
      _passvisible = !_passvisible;
    });
  }

  Future<LoginUser> userLoginToDashboard(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://www.srishanmugajewellery.com/admin/public/api/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email_id': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      String userFcmToken = UserPreferences.getFcmToken();

      var responseData = jsonDecode(response.body);
      var data = responseData['data'];
      var userId = data['id'].toString();
      var userName = data['user_name'].toString();
      var userMail = data['email_id'].toString();
      var userMobile = data['mobile_number'].toString();
      var userDateOfBirth = data['date_of_birth'].toString();
      var userDateOfAnniversary = data['date_of_aniversary'].toString();
      var userImage = data['user_image'].toString();
      var userGender = data['gender'].toString();

      UserPreferences.setUserId(userId);
      UserPreferences.setUserName(userName);
      UserPreferences.setUserMail(userMail);
      UserPreferences.setUserMobile(userMobile);
      UserPreferences.setUserDateOfBirth(userDateOfBirth);
      UserPreferences.setUserImage(userImage);
      UserPreferences.setUserDateOfAnniversary(userDateOfAnniversary);
      UserPreferences.setLoggedIn(true);

      //post token too
      updateFCMToken(userId, userFcmToken);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      );

      Fluttertoast.showToast(
        msg: 'Login Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return LoginUser.fromJson(data);
    }

    throw Exception(
      Fluttertoast.showToast(
        msg: 'Check the Email and Password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Image.asset(
                "asset/logo.png",
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //borderSide:BorderSide(color: lightIconsColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Email",
                      label: Text(
                        'Email',
                        style: TextStyle(color: Colors.grey),
                      ),
                      fillColor: Color(0xFFF5F5F5),
                      filled: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: TextFormField(
                obscureText: _passvisible ? false : true,
                keyboardType: TextInputType.text,
                controller: _passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //borderSide:BorderSide(color: lightIconsColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      updateStatus();
                    },
                    icon: Icon(
                      _passvisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  label: Text(
                    'Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetPasswordScreen()),
                  );

                  // if (_formkey.currentState!.validate()) {
                  //   print("Success");
                  // }
                  // login(_mobileController.text.toString(),_passwordController.text.toString());
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: 310,
                child: TextButton(
                  style: TextButton.styleFrom(
                    // primary: Colors.purpleAccent,
                    backgroundColor: Color(0xff832729),
                    // Background Color
                  ),
                  onPressed: () {
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Enter Email and Password',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }

                    userLoginToDashboard(
                      _emailController.text.toString(),
                      _passwordController.text.toString(),
                    );
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: TextButton(
                child: Text(
                  "Don't you have any Account? Sign up",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signupinput()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
