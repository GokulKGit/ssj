import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/bank_detsil_input.dart';

class bankdetail extends StatefulWidget {
  const bankdetail({Key? key}) : super(key: key);

  @override
  State<bankdetail> createState() => _bankdetailState();
}

class _bankdetailState extends State<bankdetail> {
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
                    "Bank Details Registration",
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
                  return Container(
                    //height: 380,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: bankdetailinput(),
                  );
                }),

                SizedBox(
                  height: 15,
                ),

                // bottomNavigationBar : ConvexAppBar(
                //   style: TabStyle.fixed,
                //   backgroundColor: Colors.white,
                //   activeColor: Colors.red,
                //   color: Colors.grey,
                //   curveSize: 80.0,
                //   items: const [
                //     TabItem(icon: Icons.home, title: 'home'),
                //     TabItem(icon: Icons.newspaper, title: 'market'),
                //     TabItem(icon: Icons.shopping_bag, title: 'shop'),
                //     TabItem(icon: Icons.airplane_ticket, title: 'booking'),
                //     TabItem(icon: Icons.location_city, title: 'my city'),
                //   ],
                //   initialActiveIndex: 0,
                //   onTap: (val) {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
