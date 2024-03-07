import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ssj/api/firebase/firebase_notification.dart';
import 'package:ssj/api/get/userprofile.dart';
import 'package:ssj/screen/home/dashboard.dart';
import 'package:ssj/screen/home/drawer_pages/about_us.dart';
import 'package:ssj/screen/home/drawer_pages/branches_map.dart';
import 'package:ssj/screen/home/drawer_pages/customer_care.dart';
import 'package:ssj/screen/home/drawer_pages/privacy_policy.dart';
import 'package:ssj/screen/home/drawer_pages/terms.dart';
import 'package:ssj/screen/home/joinScheme/goldscheme.dart';
import 'package:ssj/screen/home/profile/drawer_profile.dart';
import 'package:ssj/screen/home/profile/profile.dart';
import 'package:ssj/screen/login/login.dart';
import 'package:ssj/screen/notification/notifaction.dart';
import 'package:ssj/screen/pdf_view/show_brochures.dart';
import 'package:ssj/screen/splash_screen.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:ssj/util/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screen/more/more.dart';

void main() async {
  // Connect the firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize FirebaseNotification
  FirebaseNotification firebaseNotification = FirebaseNotification();
  await firebaseNotification.initNotification();

  FirebaseMessaging.instance.subscribeToTopic('all');
  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white, //here you can give the text color

          backgroundColor: BASECOLOR,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        useMaterial3: true,
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) => BASECOLOR),
        ),
        primarySwatch: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        secondaryHeaderColor: Color(0xff832729),
        primaryColor: Color(0xff832729),
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xff832729),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xff832729),
          splashColor: Color(0xff832729),
        ),
      ),

      // home: SplashScreen(),
      home: SplashScreen(
        firebaseNotification: firebaseNotification,
      ),
    ),
  );
}

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    // print("user da " + userId);
    // print("fcm da " + userFcmToken);
    // print("fcm da " + userName);
    // updateFCMToken(userId, userFcmToken);

    print("done");
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedpage = 2;
  String userId = UserPreferences.getUserId();

  String userName = UserPreferences.getUserName();
  String userMail = UserPreferences.getUserMail();
  String userImage = UserPreferences.getUserImage();

  @override
  Widget build(BuildContext context) {
    final _pageOption = [
      const NotificationHistory(),
      GoldSchemesWidget(),
      const homescreen(),
      ProfileScreen(),
      const MoreFeature(),
    ];

    String userName = UserPreferences.getUserName();

    Future<UserProfileData> fetchProfile() async {
      String userId = UserPreferences.getUserId();

      final response =
          await http.get(Uri.parse('$BASEURL/public/api/getuser/$userId'));

      //https://www.srishanmugajewellery.com/admin/public/api/getuser/13

      if (response.statusCode == 200) {
        return UserProfileData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    }

    return WillPopScope(
      onWillPop: () async {
        // Show a dialog to confirm if the user wants to go back
        bool confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Confirm'),
              content: Text('Are you confirm to exit app?'),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff832729)),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Return false to prevent going back
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff832729)),
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Return true to allow going back
                  },
                ),
              ],
            );
          },
        );
        return confirm ?? false; // Return false by default
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            CircleAvatar(
              backgroundColor: BASECOLOR,
              radius: 25,
            )
            // FutureBuilder<UserProfileData>(
            //     future: fetchProfile(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Padding(
            //           padding: const EdgeInsets.only(right: 10),
            //           child: CircleAvatar(
            //             backgroundColor: FONTCOLOR,
            //             radius: 23,
            //           ),
            //         );
            //       } else if (snapshot.hasData) {
            //         CircleAvatar(
            //           backgroundColor: FONTCOLOR,
            //           radius: 23,
            //           child: Text(
            //             userName[0].toUpperCase(),
            //             style: TextStyle(
            //                 color: Color(0xff832729),
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         );
            //       }
            //
            //       final showProfile = snapshot.data;
            //       return Padding(
            //         padding: const EdgeInsets.only(right: 10),
            //         child: GestureDetector(
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => DrawerProfile(),
            //               ),
            //             );
            //           },
            //           child: CircleAvatar(
            //               backgroundColor: Color.fromARGB(255, 0, 0, 0),
            //               radius: 23,
            //               child: showProfile!.user.userImage.isEmpty
            //                   ? CircleAvatar(
            //                       backgroundColor: Colors.white,
            //                       radius: 50,
            //                       child: Text(
            //                         showProfile.user.userName[0].toUpperCase(),
            //                         style: TextStyle(color: Color(0xff832729)),
            //                       ),
            //                     )
            //                   : CircleAvatar(
            //                       backgroundColor:
            //                           Color.fromARGB(255, 255, 255, 255),
            //                       radius: 50,
            //                       backgroundImage: NetworkImage(USERIMAGEURL +
            //                           showProfile.user.userImage),
            //                     )),
            //         ),
            //       );
            //     }),
          ],
          backgroundColor: Color(0xff832729),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 50,
                width: 50,
                image: AssetImage("asset/logo.png"),
              ),
            ],
          ),
        ),
        drawer: DrawerBox(userName: userName, userMail: userMail),
        body: _pageOption[selectedpage],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedpage,
          selectedItemColor: Color(0xff832729),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          //color: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Scheme",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home_filled),
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              label: "More",
            ),
          ],
          onTap: (int index) {
            // if (index == 4) {
            //   if (_scaffoldKey.currentState!.isDrawerOpen) {
            //     // Close the drawer if it's already open
            //     Navigator.pop(context);
            //   } else {
            //     // Open the drawer if it's closed
            //     _scaffoldKey.currentState!.openDrawer();
            //   }
            // }
            setState(
              () {
                selectedpage = index;
              },
            );
          },
        ),
      ),
    );
  }
}

class DrawerBox extends StatelessWidget {
  const DrawerBox({
    super.key,
    required this.userName,
    required this.userMail,
  });

  final String userName;
  final String userMail;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName.toUpperCase()),
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
                  MaterialPageRoute(
                      builder: (context) => const privacypolicy()),
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
                    FontAwesomeIcons.squareInstagram,
                    color: Color(0xffE1306C),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        "https://x.com/omalurssj?t=7JdRtWqCrUDqQaqLUTes_A&s=08"));
                  },
                  icon: Icon(
                    FontAwesomeIcons.squareXTwitter,
                    color: Colors.black,
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
                IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        "https://www.youtube.com/@SriShanmugaJewellery"));
                  },
                  icon: Icon(
                    FontAwesomeIcons.youtube,
                    color: Colors.redAccent,
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
      ),
    );
  }
}
