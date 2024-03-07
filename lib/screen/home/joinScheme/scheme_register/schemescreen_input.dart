import 'dart:convert';
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_loading_button/progress_loading_button.dart';
import 'package:ssj/api/get/goldschemedata.dart';
import 'package:ssj/main.dart';
import 'package:ssj/shareprefernce/loginchecker.dart';
import 'package:ssj/util/constant.dart';
import 'package:ssj/util/defaultvaluebox.dart';

import '../../../../util/sendmailer.dart';
import '../../myschemes/myschemes.dart';

class schemescreeninput extends StatefulWidget {
  schemescreeninput(
      {required this.masterId,
      required this.schemeId,
      required this.schemeName});

  int masterId;
  int schemeId;
  String schemeName;

  @override
  State<schemescreeninput> createState() => _schemescreeninputState();
}

class _schemescreeninputState extends State<schemescreeninput> {
  //container text

  TextEditingController nominee_type = TextEditingController();
  TextEditingController nominee_name = TextEditingController();
  TextEditingController proof = TextEditingController();

  //proof image

  TextEditingController bankname = TextEditingController();
  TextEditingController accountholder = TextEditingController();
  TextEditingController accountno = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController ifsccode = TextEditingController();
  TextEditingController panno = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController scheme_amount = TextEditingController();
  TextEditingController nominee_mobile = TextEditingController();
  TextEditingController address_1 = TextEditingController();
  TextEditingController address_2 = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController proofnoController = TextEditingController();

  //CSC
  String CountryName = "";
  String StateName = "";
  String CityName = "";

  File? _image;

  bool isLoading = false;

  String userId = UserPreferences.getUserId();
  String userName = UserPreferences.getUserName();
  String userEmail = UserPreferences.getUserMail();
  String userContact = UserPreferences.getUserMobile();

  // Function to pick an image from the device's gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  List<String> items = ["Select Scheme Amount"];
  String? selectedItem = "Select Scheme Amount";

  Future<GoldSchemes>? _goldSchemes;

  Future<GoldSchemes> fetchGoldScheme() async {
    final response =
        await http.get(Uri.parse('$BASEURL/public/api/goldschemes'));

    if (response.statusCode == 200) {
      final goldSchemes = GoldSchemes.fromJson(jsonDecode(response.body));

      // Extract scheme amounts
      for (var scheme in goldSchemes.data) {
        for (var amount in scheme.schemeAmount) {
          if (scheme.id == widget.schemeId) {
            // items.add("\u20B9 " + amount.toString());
            items.add(amount.toString());
          }
        }
      }

      return goldSchemes;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    _goldSchemes = fetchGoldScheme();
    super.initState();
  }

  List<String> nomineeType = [
    "Select Nominee Type",
    "Father",
    "Mother",
    "Son",
    "Daughter",
    "Husband",
    "Wife"
  ];
  String? nomineeTypeDefault = "Select Nominee Type";

  List<String> proofType = [
    "Select Proof Type",
    "Aadhaar Card",
    "PAN Card",
  ];
  String? proofTypeDefault = "Select Proof Type";
  // Function to send product data in an HTTP POST request
  Future<void> _uploadProducts() async {
    if (_image == null) {
      print('Please select an image.');
      return;
    }

    final url = Uri.parse(
        'https://www.srishanmugajewellery.com/admin/public/api/allform');

    try {
      var request = await http.MultipartRequest('POST', url);

      // Set all the fields
      request.fields['master_id'] = MASTERID.toString(); //gold
      request.fields['user_id'] = userId.toString();
      request.fields['nominee_type'] = nomineeTypeDefault.toString();
      request.fields['nominee_name'] = nominee_name.text;
      request.fields['proof_no'] = proofnoController.text;
      request.fields['proof_type'] = proofTypeDefault.toString();
      request.fields['bankname'] = bankname.text;
      request.fields['accountholder'] = accountholder.text;
      request.fields['accountno'] = accountno.text;
      request.fields['branch'] = branch.text;
      request.fields['ifsccode'] = ifsccode.text;
      request.fields['gold_id'] = widget.schemeId.toString();
      request.fields['scheme_amount'] = selectedItem.toString();
      request.fields['username'] = userName.toString();
      request.fields['pincode'] = pincode.text;
      request.fields['country'] = CountryName.toString();
      request.fields['state'] = StateName.toString();
      request.fields['city'] = CityName.toString();
      request.fields['mail_id'] = userEmail.toString();
      request.fields['address_1'] = address_1.text;
      request.fields['address_2'] = address_2.text;
      request.fields['nominee_mobile'] = nominee_mobile.text; // no

      request.fields['athar_number'] =
          proofTypeDefault == "Aadhaar Card" ? proofnoController.text : "NULL";
      request.fields['status'] = "Pending";
      request.fields['panno'] =
          proofTypeDefault == "PAN Card" ? proofnoController.text : "NULL";
      //
      // // Attach the selected image to the request
      // request.files.add(await http.MultipartFile.fromPath(
      //   'proof_image',
      //   _image!.path,
      // ));

      // Add text fields for product_category_id and product_name

      // You can also add other data to the request, such as headers or additional fields

      // final response = await request.send();

      // Attach the selected image to the request
      request.files
          .add(await http.MultipartFile.fromPath('proof_image', _image!.path));

      // Send the request after setting all fields
      var response = await request.send().timeout(Duration(seconds: 30));

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        print('Response: $jsonResponse');

        Fluttertoast.showToast(
            msg: "Scheme Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);

        sendSchemeMail(
          subject: "Scheme Registered Successfully",
          userMail: userEmail.toString(),
          userName: userName.toString(),
          schemeName: widget.schemeName.toString(),
          amount: selectedItem.toString(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MySchemeDataWidget(),
          ),
        );
      } else {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        print('Error Response: $jsonResponse');

        Fluttertoast.showToast(
            msg: "Something Went Wrong. Error Code: ${response.statusCode}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.pop(context);
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Something went wrong, Try Again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShowDetails(title: "Scheme Title", userDetail: widget.schemeName),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                // ${widget.schemeId}
                "Scheme Amount *",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff832729),
                ),
              ),
            ),

            FutureBuilder<GoldSchemes>(
              future: _goldSchemes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: Center(child: Text("Loading...")),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF5F5F5),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Color(0xFFF5F5F5),
                        filled: true,
                      ),
                      value: selectedItem,
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child:
                                    Text(item, style: TextStyle(fontSize: 15)),
                              ))
                          .toList(),
                      onChanged: (item) => setState(() => selectedItem = item),
                    ),
                  );
                }
              },
            ),
            //Text("\u20B9 " + selectedItem.toString()),
            SizedBox(
              height: 10,
            ),
            ShowDetails(title: "Username", userDetail: userName),
            SizedBox(
              height: 10,
            ),
            ShowDetails(title: "Email", userDetail: userEmail),

            SizedBox(
              height: 10,
            ),
            ShowDetails(title: "Contact Number", userDetail: userContact),

            SizedBox(
              height: 10,
            ),
            Text(
              "Address 1 *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.text,
              controller: address_1,
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Address 2",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.text,
              controller: address_2,
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

            SizedBox(
              height: 20,
            ),
            CSCPicker(
              ///placeholders for dropdown search field
              countrySearchPlaceholder: "Country",
              stateSearchPlaceholder: "State",
              citySearchPlaceholder: "City",

              ///labels for dropdown
              countryDropdownLabel: "*Country",
              stateDropdownLabel: "*State",
              cityDropdownLabel: "*City",

              dropdownDecoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              layout: Layout.vertical,
              defaultCountry: CscCountry.India,
              onCountryChanged: (country) {
                CountryName = country;
              },
              onStateChanged: (state) {
                StateName = state ?? "";
              },
              onCityChanged: (city) {
                CityName = city ?? "";
              },
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              "Pincode *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.number,
              maxLength: 6,
              controller: pincode,

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

            SizedBox(
              height: 10,
            ),
            Text(
              "User Proof *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  //borderSide:BorderSide(color: lightIconsColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                // hintText: "Scheme Title",
                // label: Text(
                //   'Scheme Title',
                //   style: TextStyle(color: Colors.grey),
                // ),
                fillColor: Color(0xFFF5F5F5),
                filled: true,
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.only(left: 270),
                //   child: Icon(Icons.remove_red_eye),
                // ),
              ),
              value: proofTypeDefault,
              items: proofType
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 15)),
                      ))
                  .toList(),
              onChanged: (item) => setState(() => proofTypeDefault = item),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Proof Number *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              maxLength: proofTypeDefault == "Aadhaar Card" ? 12 : 10,
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: proofTypeDefault == "Aadhaar Card"
                  ? TextInputType.number
                  : TextInputType.text,
              controller: proofnoController,

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

            SizedBox(
              height: 30,
            ),

            Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 250,
                child: _image != null
                    ? GestureDetector(
                        onTap: _pickImage,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.contain,
                        ),
                      )
                    : GestureDetector(
                        onTap: _pickImage,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            'asset/proof.png',
                            width: double.infinity,
                          ),
                        ),
                      ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff832729),
              ),
              onPressed: _pickImage,
              child: Center(
                  child: Text(
                "Upload Proof Image *",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                "Nominee Type *",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff832729),
                ),
              ),
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  //borderSide:BorderSide(color: lightIconsColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                // hintText: "Scheme Title",
                // label: Text(
                //   'Scheme Title',
                //   style: TextStyle(color: Colors.grey),
                // ),
                fillColor: Color(0xFFF5F5F5),
                filled: true,
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.only(left: 270),
                //   child: Icon(Icons.remove_red_eye),
                // ),
              ),
              value: nomineeTypeDefault,
              items: nomineeType
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 15)),
                      ))
                  .toList(),
              onChanged: (item) => setState(() => nomineeTypeDefault = item),
            ),
            SizedBox(
              height: 10,
            ),

            Text(
              "Nominee Contact Number *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              keyboardType: TextInputType.number,
              controller: nominee_mobile,
              maxLength: 10,
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

            Text(
              "Nominee Name *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.text,
              controller: nominee_name,
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

            SizedBox(
              height: 25,
            ),

            Center(
              child: Text(
                "Bank Details",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),

            Text(
              "Bank Name *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              keyboardType: TextInputType.text,
              controller: bankname,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  //borderSide:BorderSide(color: lightIconsColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Color(0xFFF5F5F5),
                filled: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Account Holder *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.text,
              controller: accountholder,
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Account No *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.number,
              controller: accountno,
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Branch *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.text,
              controller: branch,
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
            SizedBox(
              height: 10,
            ),
            Text(
              "IFSC Code *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff832729),
              ),
            ),

            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.text,
              controller: ifsccode,
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

            SizedBox(
              height: 30,
            ),

            LoadingButton(
              color: BASECOLOR,
              defaultWidget: Text('Join Scheme'),
              textcolor: FONTCOLOR,
              borderRadius: 50,
              width: 196,
              height: 60,
              onPressed: () async {
                if (selectedItem == "Select Scheme Amount") {
                  Fluttertoast.showToast(
                      msg: 'Select Scheme Amount',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (address_1.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Address 1',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (CityName.isEmpty || StateName.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'City or State not given',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (pincode.text.isEmpty || pincode.text.length < 6) {
                  Fluttertoast.showToast(
                      msg: 'Enter a Pincode',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (proofTypeDefault == "Select Proof Type") {
                  Fluttertoast.showToast(
                      msg: 'Select Proof Type',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (proofnoController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Proof Number',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (_image == null) {
                  Fluttertoast.showToast(
                      msg: 'Add Proof Image',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  // ignore: unrelated_type_equality_checks
                } else if (nomineeTypeDefault == "Select Nominee Type") {
                  Fluttertoast.showToast(
                      msg: 'Select Nominee Type',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (nominee_mobile.text.isEmpty ||
                    nominee_mobile.text.length < 9) {
                  Fluttertoast.showToast(
                      msg: 'Enter Nominee Contact Number',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (nominee_name.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Nominee Name',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (bankname.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Bank Name',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (accountholder.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Account Holder',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (accountno.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Account Number',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (branch.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Branch',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (ifsccode.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter IFSC Code',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (!userId.isEmpty) {
                  _uploadProducts();
                  await Future.delayed(
                    Duration(milliseconds: 7000),
                    () {},
                  );
                }
              },
            ),

            SizedBox(
              height: 20,
            ),
            //Center(child: Text("Delete Account",style: TextStyle(color: Colors.black), )),
          ],
        ),
      ),
    );
  }
}

// TextEditingController nominee_type = TextEditingController();
// TextEditingController nominee_name = TextEditingController();
// TextEditingController proof = TextEditingController();
//
// //proof image
//
// TextEditingController bankname = TextEditingController();
// TextEditingController accountholder = TextEditingController();
// TextEditingController accountno = TextEditingController();
// TextEditingController branch = TextEditingController();
// TextEditingController ifsccode = TextEditingController();
// TextEditingController panno = TextEditingController();
// TextEditingController status = TextEditingController();
// TextEditingController scheme_amount = TextEditingController();
// TextEditingController nominee_mobile = TextEditingController();
// TextEditingController address_1 = TextEditingController();
// TextEditingController address_2 = TextEditingController();
// TextEditingController area = TextEditingController();
// TextEditingController pincode = TextEditingController();
// TextEditingController proofnoController = TextEditingController();
