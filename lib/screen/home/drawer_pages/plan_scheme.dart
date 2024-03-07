import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/plan_scheme_input.dart';

class planscheme extends StatefulWidget {
  const planscheme({Key? key}) : super(key: key);

  @override
  State<planscheme> createState() => _planschemeState();
}

class _planschemeState extends State<planscheme> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
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
              //
              //  Row(
              //    mainAxisAlignment: MainAxisAlignment.end,
              //    children: [
              //      Image(
              //       height: 80,
              //       width: 80,
              //       image: AssetImage("asset/logo.png"),
              // ),
              //    ],
              //  ),

              Center(
                child: Text(
                  "Scheme Plan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Builder(builder: (context) {
                return Container(
                  width: 385,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: planschemeinput(),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
