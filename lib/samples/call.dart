import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void _makePhoneCall(String phoneNumber) async {
    var url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Call Number Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _makePhoneCall('9443028832');
            },
            child: Text('Call Number'),
          ),
        ),
      ),
    );
  }
}


//master_id:2
//user_id:1
//nominee_type:brother
//nominee_name:loges
//proof_no:243535
//proof:athar
//bankname:bank of paroda
//accountholder:gokul
//accountno:131344124124
//branch:salem
//ifsccode:52155efwefd23e1
//panno:2345678324
//status:pending
//gold_id:1
//scheme_amount:2000
//scheme_title:loges
//pincode:637504
//country:india
//state:tamilnadu
//door_no:2/123
//address_1:naduveneri
//address_2:kakapalaiyam
//area:vbm
//mail_id:allform@gmail.com
//username:allform

