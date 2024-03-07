import 'package:flutter/material.dart';
import 'package:ssj/screen/login/changepassword.dart';

import 'package:ssj/util/constant.dart';
import 'package:ssj/widgets/otpBox.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    // required this.myauth,
    required this.mail,
  }) : super(key: key);

  // final EmailOTP myauth;
  final String mail;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //Signup Method

  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
  }

  // String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff832729),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "asset/logo.png",
                height: MediaQuery.of(context).size.height * 0.16,
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: FONTCOLOR, borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 40,
                    left: 40,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const Text(
                        "We send OTP to verify your account",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff832729),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Enter OTP",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Otp(
                            otpController: otp1Controller,
                          ),
                          Otp(
                            otpController: otp2Controller,
                          ),
                          Otp(
                            otpController: otp3Controller,
                          ),
                          Otp(
                            otpController: otp4Controller,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // Button(
                      //   string: "Verify OTP",
                      //   tap: () async {
                      //     if (await widget.myauth.verifyOTP(
                      //             otp: otp1Controller.text +
                      //                 otp2Controller.text +
                      //                 otp3Controller.text +
                      //                 otp4Controller.text) ==
                      //         true) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //           content: Text(
                      //             "OTP has been verified! ✅",
                      //           ),
                      //         ),
                      //       );
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => UserDetail(
                      //             mail: widget.mail,
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //           content: Text(
                      //             "Invalid OTP",
                      //           ),
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff832729),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangePasswordScreen()));
                        },
                        child: Text(
                          'Verify OTP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
