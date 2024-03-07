import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart ' as http;
import 'package:ssj/shareprefernce/loginchecker.dart';

class bankdetailinput extends StatefulWidget {
  const bankdetailinput({Key? key}) : super(key: key);

  @override
  State<bankdetailinput> createState() => _bankdetailinputState();
}

class _bankdetailinputState extends State<bankdetailinput> {
  TextEditingController banknameController = TextEditingController();
  TextEditingController accountholderController = TextEditingController();
  TextEditingController accountnoController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController ifsccodecontroller = TextEditingController();
  TextEditingController pancontroller = TextEditingController();
  // TextEditingController panproofController = TextEditingController();
  // TextEditingController aadharcontroller = TextEditingController();
  // TextEditingController aadharproofcontroller = TextEditingController();

  Future<void> bankRequest() async {
    const url =
        'https://www.srishanmugajewellery.com/admin/public/api/userskyc';
    String bankname = banknameController.text;
    String accountholder = accountholderController.text;
    String accountno = accountnoController.text;
    String branch = branchController.text;
    String ifsccode = ifsccodecontroller.text;
    String panno = pancontroller.text;
    // String conformpassword = panproofController.text;
    // String dateofbirth = aadharcontroller.text;
    // String mobileno = aadharproofcontroller.text;

    Map<String, dynamic> requestBody = {
      'bankname': bankname,
      'accountholder': accountholder,
      'accountno': accountno,
      'branch': branch,
      'ifsccode': ifsccode,
      'panno': panno,
    };
    final response = await http.post(
      Uri.parse(url),
      body: requestBody,
    );
    print('vvvvvvv--------------------------');

    print('${response.request?.url}');

    print(response.statusCode);

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('statues--------------------------');

      final responseData = jsonDecode(response.body);
      print(responseData);
      var s = responseData['message'];
      print('kavin----------------------------------------------');
      print(s);
      Fluttertoast.showToast(
          msg: 'User registered successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // "message": "Data Found",
      if (s == 'User registered successfully') {
        print('just');
        var res = responseData['user_id'];
        print(res);

        var id = res['user_id'];

        UserPreferences.setLoggedIn(true);
        UserPreferences.setUserId(id);

        // print('kavin');
        // print(id);
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('user_id', id);
      }

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => signinpage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 230, top: 30),
          child: Text(
            "Bank Name",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            controller: banknameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 200, top: 10),
          child: Text(
            "Account Holder",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            controller: accountholderController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 220, top: 10),
          child: Text(
            "Account No",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            controller: accountnoController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 270),
              //   child: Icon(Icons.calendar_month),
              // ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 240, top: 10),
          child: Text(
            "Branch",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            controller: branchController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 270),
              //   child: Icon(Icons.calendar_month),
              // ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 220, top: 10),
          child: Text(
            "IFSC Code",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            controller: ifsccodecontroller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 270),
              //   child: Icon(Icons.remove_red_eye),
              // ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 230, top: 10),
          child: Text(
            "PAN No",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            controller: pancontroller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 270),
              //   child: Icon(Icons.remove_red_eye),
              // ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 220, top: 10),
          child: Text(
            "PAN Proof",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            //controller: panproofController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 270),
              //   child: Icon(Icons.remove_red_eye),
              // ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 220, top: 10),
          child: Text(
            "Aadhar No",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            //controller: aadharcontroller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 270),
              //   child: Icon(Icons.remove_red_eye),
              // ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 200, top: 10),
          child: Text(
            "Aadhar Proof",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: TextFormField(
            // validator: (value) {
            //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            //     return 'Please enter name';
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.text,
            //controller: aadharproofcontroller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              // hintText: "Mobile no",
              // label: Text(
              //   'Mobile no',
              //   style: TextStyle(color: Colors.grey),
              // ),

              fillColor: Color(0xFFF5F5F5),
              filled: true,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.only(left: 270),
              //   child: Icon(Icons.remove_red_eye),
              // ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 60,
          width: 310,
          child: TextButton(
            style: TextButton.styleFrom(
              // primary: Colors.purpleAccent,
              backgroundColor: Color(0xff832729),
              // Background Color
            ),
            onPressed: () async {
              bankRequest();

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => popup()),
              // );
            },
            child: Text(
              "Join Scheme",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
