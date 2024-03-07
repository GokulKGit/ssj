import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/privacy_policy_input.dart';

class privacypolicy extends StatefulWidget {
  const privacypolicy({Key? key}) : super(key: key);

  @override
  State<privacypolicy> createState() => _privacypolicyState();
}

class _privacypolicyState extends State<privacypolicy> {
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
              height: MediaQuery.of(context).size.height,
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
                Center(
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Builder(builder: (context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: privacypolicyinput(),
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
