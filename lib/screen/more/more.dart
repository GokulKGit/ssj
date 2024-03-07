import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssj/screen/home/drawer_pages/about_us.dart';
import 'package:ssj/screen/home/drawer_pages/branches_map.dart';
import 'package:ssj/screen/home/drawer_pages/customer_care.dart';
import 'package:ssj/screen/home/drawer_pages/privacy_policy.dart';
import 'package:ssj/screen/home/drawer_pages/terms.dart';
import 'package:ssj/screen/home/profile/drawer_profile.dart';
import 'package:ssj/screen/login/login.dart';
import 'package:ssj/screen/pdf_view/show_brochures.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreFeature extends StatefulWidget {
  const MoreFeature({super.key});

  @override
  State<MoreFeature> createState() => _MoreFeatureState();
}

class _MoreFeatureState extends State<MoreFeature> {
  String userName = UserPreferences.getUserName();
  String userMail = UserPreferences.getUserMail();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userMail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color(0xff832729),
              child: ClipOval(
                child: Image.asset(
                  'asset/logo.png',
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff832729),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("My Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrawerProfile()),
              );
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          ListTile(
            leading: Icon(Icons.branding_watermark),
            title: Text("Branches"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const branchesmap()),
              );
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          ListTile(
            leading: Icon(Icons.radio),
            title: Text("Brochures"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PdfViewerScreen()),
              );
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text("About us"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const aboutpage()),
              );
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy Policy"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const privacypolicy()),
              );
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          ListTile(
            leading: Icon(Icons.dashboard_customize),
            title: Text("Customer Care"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const customercare()),
              );
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          ListTile(
            leading: Icon(Icons.document_scanner),
            title: Text("Terms and Conditions"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const termspage()),
              );
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          ListTile(
            leading: Icon(Icons.web_stories),
            title: Text(
              "www.srishanmugajewellery.com",
              style: TextStyle(fontSize: 10),
            ),
            onTap: () {
              launchUrl(Uri.parse("https://www.srishanmugajewellery.com"));
            },
            trailing: Icon(
              Icons.arrow_right,
              size: 35,
            ),
          ),
          Divider(
            color: Color(0xff832729),
            indent: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "FOLLOW US",
                style: TextStyle(color: Color(0xFFB71C1C)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(
                      "https://www.facebook.com/shanmugajewellery?mibextid=ViGcVu"));
                },
                icon: Icon(
                  Icons.facebook,
                  color: Colors.blue[900],
                ),
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(
                      "https://instagram.com/sri.shanmuga.jewellery?igshid=YzAwZjE1ZTI0Zg"));
                },
                icon: Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.pinkAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(
                      "https://x.com/omalurssj?t=7JdRtWqCrUDqQaqLUTes_A&s=08"));
                },
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blueAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(
                      "https://www.linkedin.com/in/shanmuga-jewellery-773765284?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app"));
                },
                icon: Icon(
                  FontAwesomeIcons.linkedin,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff832729), // Background color
            ),
            onPressed: () {
              UserPreferences.setLoggedIn(false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => signininput()));
            },
            child: Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(color: Color(0xFFB71C1C)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
    // Center(
    //   child: Container(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image.asset("asset/more.png"),
    //         Text(
    //           "More Feature Coming Soon!",
    //           textAlign: TextAlign.center,
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
