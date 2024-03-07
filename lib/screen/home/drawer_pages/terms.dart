import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/terms_input.dart';

class termspage extends StatefulWidget {
  const termspage({Key? key}) : super(key: key);

  @override
  State<termspage> createState() => _termspageState();
}

class _termspageState extends State<termspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(),
        backgroundColor: Color(0xff832729),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Color(0xff832729),
                radius: 0, // Image radius
                backgroundImage: AssetImage('asset/logo.png'),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xff832729),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: termspageinput(),
                    ),
                  );
                }),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
