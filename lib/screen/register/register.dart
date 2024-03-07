// import 'package:flutter/material.dart';
// import 'package:ssj/api/post/userregister.dart';

// class Registration extends StatefulWidget {
//   const Registration({super.key});

//   @override
//   State<Registration> createState() => _RegistrationState();
// }

// class _RegistrationState extends State<Registration> {

//   TextEditingController _name = new TextEditingController();
//   TextEditingController _email = new TextEditingController();
//   TextEditingController _password = new TextEditingController();
//   TextEditingController _dob = new TextEditingController();
//   TextEditingController _mobile = new TextEditingController();
//   TextEditingController _gender = new TextEditingController();

//   Future<Register>? _register;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   Text(
//                     "Registration",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   MyTextWidget(
//                     lable: "Name",
//                     myController: _name,
//                   ),
//                   MyTextWidget(
//                     lable: "Mail",
//                     myController: _email,
//                   ),
//                   MyTextWidget(
//                     lable: "Password",
//                     myController: _password,
//                   ),
//                   MyTextWidget(
//                     lable: "Confirm Password",
//                     myController: _password,
//                   ),
//                   MyTextWidget(
//                     lable: "Date Of Birth",
//                     myController: _dob,
//                   ),
//                   MyTextWidget(
//                     lable: "Mobile Number",
//                     myController: _mobile,
//                   ),
//                   MyTextWidget(
//                     lable: "Gender",
//                     myController: _gender,
//                   ),

//                   //date of ann
//                   //imag,
//                   Text(_name.text),
//                   Text(_email.text),
//                   Text(_password.text),
//                   Text(_dob.text),
//                   Text(_mobile.text),
//                   Text(_gender.text),

//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _register = createUser(
//                           user_name: _name,
//                           email_id: _email,
//                           password: _password,
//                           conform_password: _password,
//                           date_of_birth: _dob,
//                           mobile_number: _mobile,
//                           gender: _gender,
//                           ctx: context,
//                         );
//                       });
//                     },
//                     child: Text(" Register "),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyTextWidget extends StatelessWidget {
//   MyTextWidget({required this.lable, required this.myController});

//   String lable;
//   TextEditingController myController;

import 'dart:convert';

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: TextFormField(
//         controller: myController,
//         decoration: InputDecoration(
//           label: Text(lable),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(
//               10,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(
//               10,
//             ),
//             borderSide: BorderSide(
//               width: 2,
//               color: Colors.red,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ssj/screen/login/login.dart';
import 'package:ssj/util/constant.dart';
import 'package:ssj/util/sendmailer.dart';

class signupinput extends StatefulWidget {
  const signupinput({Key? key}) : super(key: key);

  @override
  State<signupinput> createState() => _signupinputState();
}

class _signupinputState extends State<signupinput> {
  //late DataModel _dataModel;

  TextEditingController usernameController = TextEditingController();
  TextEditingController email_idController = TextEditingController();
  TextEditingController date_of_birthController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conform_passwordcontroller = TextEditingController();
  TextEditingController mobile_numbercontroller = TextEditingController();
  TextEditingController otp_Controller = TextEditingController();
  EmailOTP myauth = EmailOTP();

  final currentYear = DateTime.now().year;
  var getUserBirthYear = 0;
  var calculateYear = 0;

  String selectedGender = ''; // Variable to hold the selected gender

  bool isdisable = false;

  void setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  // Email verification
  bool _isValid = false;

  bool _validateEmail(String email) {
    // Regular expression for basic email validation
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegExp.hasMatch(email);
  }

  void _validateInput(String input) {
    setState(() {
      _isValid = _validateEmail(input);
    });
  }

  bool _passvisible = false;

  void updateStatus() {
    setState(() {
      _passvisible = !_passvisible;
    });
  }

  String password = '';
  bool isStrong = false;

  void checkPasswordStrength(String value) {
    setState(() {
      password = value;
      isStrong = _isStrongPassword(password);
    });
  }

  bool _isStrongPassword(String password) {
    // Add your password strength criteria here
    // For example, check for minimum length, uppercase, lowercase, numbers, etc.
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  Future<void> loginPostRequest() async {
    const url =
        'https://www.srishanmugajewellery.com/admin/public/api/userregister';
    String name = usernameController.text;
    String email = email_idController.text;
    String password = passwordController.text;
    String conformpassword = conform_passwordcontroller.text;
    String dateofbirth = date_of_birthController.text;
    String mobileno = mobile_numbercontroller.text;
    String gender = selectedGender;
    Map<String, dynamic> requestBody = {
      'user_name': name,
      'email_id': email,
      'password': password,
      'conform_password': conformpassword,
      'date_of_birth': dateofbirth,
      'mobile_number': mobileno,
      'gender': gender,
      'fcm_token': ""
    };
    final response = await http.post(
      Uri.parse(url),
      body: requestBody,
    );
    print('vvvvvvv--------------------------');

    final responseData = jsonDecode(response.body);
    print(responseData["message"]);

    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData["message"]);

      Fluttertoast.showToast(
          msg: 'User registered successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      sendMail(
          subject: "Hi $name, Welcome to Sri Shanmuga Jewellery!",
          userMail: email);
      // "message": "Data Found",
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => signininput(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: '${responseData["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // void sendOTP() async {
  //   var res = await EmailAuth.;
  // }

  @override
  Widget build(BuildContext context) {
    // Generate a random number between 1000 and 9999 (inclusive)

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Center(
              child: Image.asset(
                "asset/logo.png",
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: const Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Color(0xff832729),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: usernameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //borderSide:BorderSide(color: lightIconsColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Username",
                    label: Text(
                      'Username',
                      style: TextStyle(color: Colors.grey),
                    ),
                    fillColor: Color(0xFFF5F5F5),
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                onChanged: _validateInput,
                keyboardType: TextInputType.emailAddress,
                controller: email_idController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //borderSide:BorderSide(color: lightIconsColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Email",
                  label: Text(
                    'Email',
                    style: TextStyle(color: Colors.grey),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
              ),
            ),
            Text(
              email_idController.text.isEmpty
                  ? ""
                  : _isValid
                      ? 'Valid Email'
                      : 'Invalid Email',
              style: TextStyle(
                color: _isValid ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 50, right: 50),
            //   child: Center(
            //       child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: Color(0xff832729)),
            //           onPressed: isdisable
            //               ? null
            //               : () async {
            //                   try {
            //                     myauth.setConfig(
            //                       appEmail: "srishanmugajewellery23@gmail.com",
            //                       appName:
            //                           "Please use the OTP verification code below on the SSJ App",
            //                       userEmail: email_idController.text,
            //                       otpLength: 6,
            //                       otpType: OTPType.digitsOnly,
            //                     );
            //
            //                     bool otpSent = await myauth.sendOTP();
            //
            //                     if (otpSent &&
            //                         email_idController.text.isNotEmpty) {
            //                       setState(() {
            //                         isdisable = true;
            //                       });
            //                       ScaffoldMessenger.of(context).showSnackBar(
            //                         const SnackBar(
            //                           content: Text("OTP has been sent"),
            //                         ),
            //                       );
            //                     } else if (email_idController.text.isEmpty) {
            //                       setState(() {
            //                         isdisable = false;
            //                       });
            //                       ScaffoldMessenger.of(context).showSnackBar(
            //                         const SnackBar(
            //                           content: Text("Enter Email"),
            //                         ),
            //                       );
            //                     } else if (!_isValid) {
            //                       setState(() {
            //                         isdisable = false;
            //                       });
            //                       ScaffoldMessenger.of(context).showSnackBar(
            //                         const SnackBar(
            //                           content: Text("Enter Valid Email"),
            //                         ),
            //                       );
            //                     } else {
            //                       ScaffoldMessenger.of(context).showSnackBar(
            //                         const SnackBar(
            //                           content: Text("Oops, OTP send failed"),
            //                         ),
            //                       );
            //                     }
            //                   } catch (e) {
            //                     print("Error: $e");
            //                     // Handle the error as needed
            //                     ScaffoldMessenger.of(context).showSnackBar(
            //                       const SnackBar(
            //                         content: Text(
            //                             "An error occurred while processing the request"),
            //                       ),
            //                     );
            //                   }
            //                 },
            //           child: Center(
            //             child: Text(
            //               "Send OTP",
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ))),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            //   child: TextFormField(
            //     keyboardType: TextInputType.number,
            //     controller: otp_Controller,
            //     decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: const BorderSide(color: Colors.white),
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         //borderSide:BorderSide(color: lightIconsColor),
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       hintText: "Enter OTP",
            //       label: Text(
            //         'Enter OTP',
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //       fillColor: Color(0xFFF5F5F5),
            //       filled: true,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Choose Your Gender',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setSelectedGender(value.toString());
                    },
                  ),
                  Text('Male'),
                  SizedBox(width: 20),
                  Radio(
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setSelectedGender(value.toString());
                    },
                  ),
                  Text('Female'),
                  SizedBox(width: 20),
                  Radio(
                    value: 'Other',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setSelectedGender(value.toString());
                    },
                  ),
                  Text('Other'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: date_of_birthController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //borderSide:BorderSide(color: lightIconsColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Date of Birth',
                    label: Text(
                      'Date of Birth',
                      style: TextStyle(color: Colors.grey),
                    ),
                    suffixIcon: const Icon(
                      Icons.date_range,
                      color: Colors.grey,
                    ),
                    fillColor: Color(0xFFF5F5F5),
                    filled: true,
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                    );

                    if (pickeddate != null && pickeddate != DateTime.now()) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickeddate);
                      setState(() {
                        date_of_birthController.text = formattedDate;
                        print(pickeddate.year);
                        getUserBirthYear = pickeddate.year;
                        calculateYear = currentYear - getUserBirthYear;
                        print(calculateYear);
                      });
                    } else {
                      print("Enter Your DOB");
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                onChanged: (value) => checkPasswordStrength(value),
                obscureText: _passvisible ? false : true,
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
                  hintText: "Password",
                  label: Text(
                    'Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      updateStatus();
                    },
                    icon: Icon(
                      _passvisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
              ),
            ),
            isStrong
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Strong Password!',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Password must contain [0-9] [a-z] [A-Z]',
                      style: TextStyle(
                        color: BASECOLOR,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                    return 'Please enter password';
                  }
                  return null;
                },
                obscureText: _passvisible ? false : true,
                keyboardType: TextInputType.visiblePassword,
                controller: conform_passwordcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //borderSide:BorderSide(color: lightIconsColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Confirm Password",
                  label: Text(
                    'Confirm Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      updateStatus();
                    },
                    icon: Icon(
                      _passvisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: mobile_numbercontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    //borderSide:BorderSide(color: lightIconsColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "mobile no",
                  label: Text(
                    'Mobile Number',
                    style: TextStyle(color: Colors.grey),
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  if (usernameController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Enter Username',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (email_idController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Enter Email',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (mobile_numbercontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Enter Mobile Number',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (mobile_numbercontroller.text.length < 10) {
                    Fluttertoast.showToast(
                      msg: 'Mobile Number must have 10 digit',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (selectedGender == "") {
                    Fluttertoast.showToast(
                      msg: 'Select Gender',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (conform_passwordcontroller.text !=
                      passwordController.text) {
                    Fluttertoast.showToast(
                      msg: 'Password not match',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (passwordController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Enter Password',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (passwordController.text.length < 1 || !isStrong) {
                    Fluttertoast.showToast(
                      msg: 'Weak Password',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (calculateYear < 18) {
                    Fluttertoast.showToast(
                      msg: 'Age must be above 18',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    loginPostRequest();
                  }
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text("OTP is verified"),
                  //   ));
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text("Invalid OTP"),
                  //   ));
                },
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Color(0xff832729),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Verify & Signup',
                      style: (TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: TextButton(
                child: Text(
                  "You have any Account? Sign In",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => signininput()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

// UserPreferences.setLoggedIn(true);
// UserPreferences.setUserId(id);
