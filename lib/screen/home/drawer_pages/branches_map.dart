import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/branches_map_input.dart';
import 'package:ssj/util/constant.dart';

class branchesmap extends StatefulWidget {
  const branchesmap({Key? key}) : super(key: key);

  @override
  State<branchesmap> createState() => _branchesmapState();
}

class _branchesmapState extends State<branchesmap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BASECOLOR,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: BASECOLOR,
                radius: 0, // Image radius
                backgroundImage: AssetImage('asset/logo.png'),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: BASECOLOR,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Branches",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    //width: 380,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: branchesmapinput(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
