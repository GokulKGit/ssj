import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssj/screen/login/otpscreen.dart';
import 'package:ssj/util/constant.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BASECOLOR,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .25,
            ),
            Text(
              "Verification",
              style: TextStyle(
                  color: FONTCOLOR, fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * .55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: FONTCOLOR,
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "asset/logo.png",
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                Text("forgot password"),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //borderSide:BorderSide(color: lightIconsColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Phone Number",
                      label: Text(
                        'Phone Number',
                        style: TextStyle(color: Colors.grey),
                      ),
                      fillColor: Color(0xFFF5F5F5),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff832729),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                  mail: 'gk569764@gmail.com',
                                )));
                  },
                  child: Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
