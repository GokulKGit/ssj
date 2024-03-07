import 'package:flutter/material.dart';
import 'package:ssj/screen/login/login.dart';
import 'package:ssj/util/constant.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BASECOLOR,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .20,
            ),
            Text(
              "Change Password",
              style: TextStyle(
                  color: FONTCOLOR, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * .6,
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
                      hintText: "New Password",
                      label: Text(
                        'New Password',
                        style: TextStyle(color: Colors.grey),
                      ),
                      fillColor: Color(0xFFF5F5F5),
                      filled: true,
                    ),
                  ),
                ),
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
                      hintText: "Confirm Password",
                      label: Text(
                        'Confirm Password',
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => signininput()));
                  },
                  child: Text(
                    'Submit',
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
