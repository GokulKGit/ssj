import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/bank_detail.dart';

class schemenomeneeinput extends StatelessWidget {
  const schemenomeneeinput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 230, top: 30),
          child: Text(
            "UserName",
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
            //controller: _nameController,
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
          padding: const EdgeInsets.only(right: 230, top: 10),
          child: Text(
            "Email ID",
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
            //controller: _nameController,
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
          padding: const EdgeInsets.only(right: 210, top: 10),
          child: Text(
            "Date of birth",
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
            //controller: _nameController,
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
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 270),
                child: Icon(Icons.calendar_month),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 225, top: 10),
          child: Text(
            "Pincode",
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
            //controller: _nameController,
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
          padding: const EdgeInsets.only(right: 230, top: 10),
          child: Text(
            "Country",
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
            //controller: _nameController,
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
          padding: const EdgeInsets.only(right: 240, top: 10),
          child: Text(
            "State",
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
            //controller: _nameController,
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
          padding: const EdgeInsets.only(right: 240, top: 10),
          child: Text(
            "Area",
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
            //controller: _nameController,
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
            "Door No*",
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
            //controller: _nameController,
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
          padding: const EdgeInsets.only(right: 210, top: 10),
          child: Text(
            "Address 1*",
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
            //controller: _nameController,
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
          padding: const EdgeInsets.only(right: 210, top: 10),
          child: Text(
            "Address 2*",
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
            //controller: _nameController,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => bankdetail()),
              );
            },
            child: Text(
              "Next",
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
