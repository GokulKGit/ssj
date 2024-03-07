// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ssj/screen/home/dashboard.dart';
// import 'package:ssj/screen/home/joinScheme/goldscheme.dart';
// import 'package:ssj/screen/home/profile/profile.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Bottom Navigation Bar',
//       home: HomePage(),
//     ),
//   );
// }

// class HomePage extends StatefulWidget {
//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   var currentIndex = 0;

//   final _pageOptions = [
//     // Replace these with your actual pages
//     // Profile(),
//     // GoldSchemesWidget(),
//     // homescreen(),
//     // Profile(),
//     // Drawer(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double displayWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: _pageOptions[currentIndex], // Display the selected page
//       bottomNavigationBar: Container(
//         margin: EdgeInsets.all(displayWidth * 0.05),
//         height: displayWidth * 0.155,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 30,
//               offset: Offset(0, 10),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: ListView.builder(
//           itemCount: 4,
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.symmetric(horizontal: displayWidth * 0.02),
//           itemBuilder: (context, index) => InkWell(
//             onTap: () {
//               setState(() {
//                 currentIndex = index; // Update the selected index
//                 HapticFeedback.lightImpact();
//               });
//             },
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             child: Stack(
//               children: [
//                 AnimatedContainer(
//                   duration: Duration(seconds: 1),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   width: index == currentIndex
//                       ? displayWidth * 0.32
//                       : displayWidth * 0.18,
//                   alignment: Alignment.center,
//                   child: AnimatedContainer(
//                     duration: Duration(seconds: 1),
//                     curve: Curves.fastLinearToSlowEaseIn,
//                     height: index == currentIndex ? displayWidth * 0.12 : 0,
//                     width: index == currentIndex ? displayWidth * 0.32 : 0,
//                     decoration: BoxDecoration(
//                       color: index == currentIndex
//                           ? Colors.blueAccent.withOpacity(0.2)
//                           : Colors.transparent,
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                   ),
//                 ),
//                 AnimatedContainer(
//                   duration: Duration(seconds: 1),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   width: index == currentIndex
//                       ? displayWidth * 0.31
//                       : displayWidth * 0.18,
//                   alignment: Alignment.center,
//                   child: Stack(
//                     children: [
//                       Row(
//                         children: [
//                           AnimatedContainer(
//                             duration: Duration(seconds: 1),
//                             curve: Curves.fastLinearToSlowEaseIn,
//                             width:
//                                 index == currentIndex ? displayWidth * 0.13 : 0,
//                           ),
//                           AnimatedOpacity(
//                             opacity: index == currentIndex ? 1 : 0,
//                             duration: Duration(seconds: 1),
//                             curve: Curves.fastLinearToSlowEaseIn,
//                             child: Text(
//                               index == currentIndex
//                                   ? '${listOfStrings[index]}'
//                                   : '',
//                               style: TextStyle(
//                                 color: Colors.blueAccent,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           AnimatedContainer(
//                             duration: Duration(seconds: 1),
//                             curve: Curves.fastLinearToSlowEaseIn,
//                             width: index == currentIndex
//                                 ? displayWidth * 0.03
//                                 : 20,
//                           ),
//                           Icon(
//                             listOfIcons[index],
//                             size: displayWidth * 0.076,
//                             color: index == currentIndex
//                                 ? Colors.blueAccent
//                                 : Colors.black26,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<IconData> listOfIcons = [
//     Icons.home_rounded,
//     Icons.favorite_rounded,
//     Icons.settings_rounded,
//     Icons.person_rounded,
//   ];

//   List<String> listOfStrings = [
//     'Home',
//     'Favorite',
//     'Settings',
//     'Account',
//   ];
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Bottom Nav Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Scaffold(
      appBar: AppBar(elevation: 10, title: Text("Home")),
      body: Center(
        child: Text("Scaffold Body"),
      ),
    ),
    PlaceholderWidget(title: 'Category'),
    PlaceholderWidget(title: 'BookMark'),
    PlaceholderWidget(title: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow),
                color: Colors.white10,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: _currentIndex == 0
                      ? Icon(Icons.home_filled)
                      : Icon(Icons.home_outlined),
                  onPressed: () => _onItemTapped(0),
                  color: _currentIndex == 0 ? Colors.yellow : Colors.grey,
                ),
                IconButton(
                  icon: Icon(Icons.category),
                  onPressed: () => _onItemTapped(1),
                  color: _currentIndex == 1 ? Colors.red : Colors.grey,
                ),
                IconButton(
                  icon: _currentIndex == 2
                      ? Icon(Icons.bookmark)
                      : Icon(Icons.bookmark_outline),
                  onPressed: () => _onItemTapped(2),
                  color: _currentIndex == 2 ? Colors.blue : Colors.grey,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => _onItemTapped(3),
                  color: _currentIndex == 3 ? Colors.green : Colors.grey,
                ),
              ],
            ),
          ),
        ));
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  PlaceholderWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
