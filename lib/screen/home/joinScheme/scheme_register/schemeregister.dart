import 'package:flutter/material.dart';
import 'package:ssj/screen/home/joinScheme/scheme_register/schemescreen_input.dart';

class schemescreen extends StatefulWidget {
  schemescreen(
      {required this.masterId,
      required this.schemeId,
      required this.schemeName,
      required this.listId});

  int masterId;
  int schemeId, listId;
  String schemeName;

  @override
  State<schemescreen> createState() => _schemescreenState();
}

class _schemescreenState extends State<schemescreen> {
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
                radius: 0,
                // Image radius
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
                    "Scheme Registration",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //height: 380,
                      //width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: schemescreeninput(
                          masterId: widget.masterId,
                          schemeId: widget.schemeId,
                          schemeName: widget.schemeName),
                    ),
                  );
                }),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
