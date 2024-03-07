// import 'package:flutter/material.dart';
// import 'package:ssj/api/get/userprofile.dart';
// import 'package:ssj/screen/home/profile/edit_profile.dart';
// import 'package:ssj/shareprefernce/loginchecker.dart';
// import 'package:ssj/util/constant.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// String userId = UserPreferences.getUserId();

// class _ProfileScreenState extends State<ProfileScreen> {
//   late Future<UserProfileData> _profile;

//   Future<UserProfileData> fetchProfile() async {
//     final response =
//         await http.get(Uri.parse('$BASEURL/public/api/getuser/$userId'));

//     //https://www.srishanmugajewellery.com/admin/public/api/getuser/13

//     if (response.statusCode == 200) {
//       return UserProfileData.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _profile = fetchProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gold s'),
//       ),
//       body: FutureBuilder<UserProfileData>(
//         future: _profile,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Container(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Stack(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.grey[200],
//                             radius: 50,
//                           ),
//                           Positioned(
//                               right: 0,
//                               bottom: 0,
//                               child: CircleAvatar(
//                                 radius: 17,
//                                 backgroundColor: Colors.white,
//                                 child: CircleAvatar(
//                                   backgroundColor: BASECOLOR,
//                                   radius: 15,
//                                   child: Icon(
//                                     Icons.photo_filter,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ))
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Text(
//                               "Profile",
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Divider(
//                             indent: 40,
//                             endIndent: 40,
//                           ),
//                           ListTile(
//                             title: Text("Username"),
//                             subtitle: Container(
//                               height: 20,
//                               width: 50,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.grey[200]),
//                             ),
//                           ),
//                           ListTile(
//                             title: Text("Email Id"),
//                             subtitle: Container(
//                               height: 30,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.grey),
//                             ),
//                           ),
//                           ListTile(
//                             title: Text("Gender"),
//                             subtitle: Container(
//                               height: 30,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.grey),
//                             ),
//                           ),
//                           ListTile(
//                             title: Text("Mobile Number"),
//                             subtitle: Container(
//                               height: 30,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.grey),
//                             ),
//                           ),
//                           ListTile(
//                             title: Text("Date Of Birth"),
//                             subtitle: Container(
//                               height: 30,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.grey),
//                             ),
//                           ),
//                           ListTile(
//                             title: Text("Date Of Anniversary"),
//                             subtitle: Container(
//                               height: 30,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.grey),
//                             ),
//                           ),
//                         ],
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff832729),
//                         ),
//                         onPressed: () {
//                           UserPreferences.setLoggedIn(false);
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => EditProfile()));
//                         },
//                         child: Text(
//                           'Edit Profile',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final showProfile = snapshot.data;
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Container(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Stack(
//                         children: [
//                           showProfile!.user.userImage.contains("null")
//                               ? CircleAvatar(
//                                   backgroundColor: Color(0xff832729),
//                                   radius: 50,
//                                   child: Text(
//                                     showProfile!.user.userName[0].toUpperCase(),
//                                     style: TextStyle(
//                                         fontSize: 30, color: Colors.white),
//                                   ),
//                                 )
//                               : CircleAvatar(
//                                   backgroundColor: Color(0xff832729),
//                                   radius: 50,
//                                   backgroundImage: NetworkImage(USERIMAGEURL +
//                                       showProfile.user.userImage),
//                                 ),
//                           Positioned(
//                               right: 0,
//                               bottom: 0,
//                               child: CircleAvatar(
//                                 radius: 17,
//                                 backgroundColor: Colors.white,
//                                 child: CircleAvatar(
//                                   backgroundColor: BASECOLOR,
//                                   radius: 15,
//                                   child: Icon(
//                                     Icons.photo_filter,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ))
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Text(
//                               "Profile",
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Divider(
//                             indent: 40,
//                             endIndent: 40,
//                           ),
//                           ListTile(
//                             title: Text("Username"),
//                             subtitle: Text(showProfile.user.userName),
//                           ),
//                           ListTile(
//                             title: Text("Email Id"),
//                             subtitle: Text(showProfile.user.emailId),
//                           ),
//                           ListTile(
//                             title: Text("Gender"),
//                             subtitle: Text(showProfile.user.gender),
//                           ),
//                           ListTile(
//                             title: Text("Mobile Number"),
//                             subtitle: Text(showProfile.user.mobileNumber),
//                           ),
//                           ListTile(
//                             title: Text("Date Of Birth"),
//                             subtitle: Text(showProfile.user.dateOfBirth),
//                           ),
//                           ListTile(
//                             title: Text("Date Of Anniversary"),
//                             subtitle: Text(showProfile.user.dateOfAniversary),
//                           ),
//                         ],
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff832729),
//                         ),
//                         onPressed: () {
//                           UserPreferences.setLoggedIn(false);
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => EditProfile()));
//                         },
//                         child: Text(
//                           'Edit Profile',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return Center(child: Text('No data available.'));
//           }
//         },
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: ProfileScreen()));
