import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/scheme_nominee_input.dart';

class schemenomenee extends StatefulWidget {
  const schemenomenee({Key? key}) : super(key: key);

  @override
  State<schemenomenee> createState() => _schemenomeneeState();
}

class _schemenomeneeState extends State<schemenomenee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff832729),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Scheme Nomenee",
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
                    //width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: schemenomeneeinput(),
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
