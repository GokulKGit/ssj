import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssj/screen/home/profile/profile.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:ssj/util/constant.dart';
import 'package:ssj/util/defaultvaluebox.dart';

import '../../../main.dart';
import 'drawer_profile.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    required this.Gender,
    required this.imageUrl,
    required this.DateOfBirth,
    required this.DateOfAnniversary,
  });

  String Gender;
  String imageUrl;
  String DateOfBirth;
  String DateOfAnniversary;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  var calculateYear = 0;
  var getUserBirthYear = 0;
  final currentYear = DateTime.now().year;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformpasswordController = TextEditingController();

  String userId = UserPreferences.getUserId();
  String userName = UserPreferences.getUserName();
  String userMail = UserPreferences.getUserMail();
  String userMobile = UserPreferences.getUserMobile();

  late DateTime date;
  DateTime? anniversary;
  String? dateOfBirth, dateOfAnniversary;

  bool _passvisible = false;
  bool _newPassvisible = false;
  bool _confirmPassvisible = false;

  Future<void> _getImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _uploadData() async {
    final String apiUrl =
        'https://www.srishanmugajewellery.com/admin/public/api/users/$userId';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add other form fields
      request.fields['user_name'] = userName;
      request.fields['email_id'] = userMail;
      request.fields['password'] = passwordController.text;
      request.fields['password_confirmation'] = conformpasswordController.text;
      request.fields['date_of_birth'] = dateOfBirth.toString();
      request.fields['mobile_number'] = userMobile;
      request.fields['date_of_aniversary'] = dateOfAnniversary.toString();
      request.fields['gender'] = widget.Gender;
      request.fields['old_password'] = oldPasswordController.text;

      // Add the image file
      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('user_image', _image!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(await response.stream.bytesToString());
        var message = responseData['message'];

        // ignore: use_build_context_synchronously

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BottomNavBar(),
        //   ),
        // );

        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        if (message == 'successful') {
          var userId = responseData['user_id'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', userId);
        }
      } else {
        print('Failed to upload data. Status code: ${response.statusCode}');
        print(await response.stream.bytesToString());
        Fluttertoast.showToast(
          msg: "Your Current Password is Incorrect!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      print('Error uploading data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.DateOfAnniversary != null &&
        widget.DateOfAnniversary != "null") {
      anniversary =
          DateFormat("yyyy-MM-dd").parse(widget.DateOfAnniversary.toString());
    } else {
      anniversary = null; // or assign a default value if necessary
    }
    date = DateFormat("yyyy-MM-dd").parse(widget.DateOfBirth.toString());
  }

  @override
  Widget build(BuildContext context) {
    dateOfBirth = DateFormat("yyyy-MM-dd").format(date);
    dateOfAnniversary = anniversary != null
        ? DateFormat("yyyy-MM-dd").format(anniversary!)
        : '';
    return WillPopScope(
      onWillPop: () async {
        // Show a dialog to confirm if the user wants to go back
        bool confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Confirm'),
              content: Text('Do you want to go back?'),
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
        appBar: AppBar(
          title: Text("Edit Profile"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("asset/logo.png"),
            )
          ],
          leading: BackButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: _image == null
                          ? widget.imageUrl.toString() ==
                                  "https://www.srishanmugajewellery.com/admin/public/userimages/"
                              ? CircleAvatar(
                                  backgroundColor: Color(0xff832729),
                                  radius: 50,
                                  child: Text(
                                    userName[0].toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Color(0xff832729),
                                  backgroundImage:
                                      NetworkImage(widget.imageUrl),
                                  radius: 50,
                                )
                          : Center(
                              child: ClipOval(
                                child: Image.file(
                                  File(_image!.path),
                                  height: 120.0,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _getImage,
                        child: Text(
                          'Change Profile',
                          style: TextStyle(color: FONTCOLOR),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff832729),
                        )),
                      ),
                    ),
                    ShowDetails(title: "Username", userDetail: userName),
                    ShowDetails(title: "Email", userDetail: userMail),
                    ShowDetails(title: "Mobile Number", userDetail: userMobile),
                    ShowDetails(title: "Gender", userDetail: widget.Gender),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Date of Birth",
                      style: TextStyle(
                          color: Color(0xff832729),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            date = selectedDate;
                            getUserBirthYear = selectedDate.year;
                            print(getUserBirthYear);
                            print(currentYear);
                            calculateYear = currentYear - getUserBirthYear;
                            print(calculateYear);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 60,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '${dateOfBirth}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Date of Anniversary",
                      style: TextStyle(
                          color: Color(0xff832729),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: anniversary,
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            anniversary = selectedDate;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 60,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '${dateOfAnniversary}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "Change Password",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Current Password",
                      style: TextStyle(
                          color: Color(0xff832729),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: _passvisible ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          //borderSide:BorderSide(color: lightIconsColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // hintText: "Password",
                        // label: Text(
                        //   'Password',
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passvisible = !_passvisible;
                            });
                          },
                          icon: Icon(
                            _passvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        fillColor: Color(0xFFF5F5F5),
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "New Password",
                      style: TextStyle(
                          color: Color(0xff832729),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: _newPassvisible ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          //borderSide:BorderSide(color: lightIconsColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // hintText: "Password",
                        // label: Text(
                        //   'Password',
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _newPassvisible = !_newPassvisible;
                            });
                          },
                          icon: Icon(
                            _newPassvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        fillColor: Color(0xFFF5F5F5),
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                          color: Color(0xff832729),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Confrim password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: _confirmPassvisible ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: conformpasswordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          //borderSide:BorderSide(color: lightIconsColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // hintText: "Password",
                        // label: Text(
                        //   'Password',
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmPassvisible = !_confirmPassvisible;
                            });
                          },
                          icon: Icon(
                            _confirmPassvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        fillColor: Color(0xFFF5F5F5),
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print(calculateYear + currentYear);
                          // if (calculateYear < 18) {
                          //   Fluttertoast.showToast(
                          //     msg: 'Age must be above 18',
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.red,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0,
                          //   );
                          // } else {
                          //   _uploadData();
                          // }

                          _uploadData();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff832729)),

                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(200,
                                50), // Adjust the width and height as needed
                          ),
                          // Other style properties can be added here
                        ),
                        child: Text(
                          'Apply Changes',
                          style: TextStyle(color: FONTCOLOR),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
