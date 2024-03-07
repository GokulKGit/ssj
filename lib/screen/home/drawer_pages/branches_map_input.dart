import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ssj/util/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class branchesmapinput extends StatefulWidget {
  const branchesmapinput({Key? key}) : super(key: key);

  @override
  State<branchesmapinput> createState() => _branchesmapinputState();
}

class _branchesmapinputState extends State<branchesmapinput> {
  GoogleMapController? _controller;
  final LatLng _desiredLocation = LatLng(11.744563025138554, 78.04590081927019);
  @override

  // 11.744563025138554, 78.04590081927019
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                children: [
                  Text(
                    "SALEM",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: BASECOLOR),
                  ),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            color: BASECOLOR,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                """
46 Main Bazaar Street, Omalur,  
Salem, 
Tamil Nadu – 636 455, India.
                """,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.height * 0.020),
              ),
              Icon(
                Icons.location_on,
                color: Color(0xff832729),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL(
                    'mailto:omalurssjcustomercare@gmail.com',
                  );
                },
                child: Text(
                  'omalurssjcustomercare@gmail.com',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: MediaQuery.of(context).size.height * 0.020),
                ),
              ),
              Icon(
                Icons.mail,
                color: Color(0xff832729),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL('tel:9498810716');
                },
                child: Text(
                  '+91 94988 10716 ',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.020,
                    color: Colors.black,
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Icon(
                Icons.call,
                color: Color(0xff832729),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 5,
            child: Container(
              height: 280,
              width: 350,
              decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _desiredLocation,
                  zoom: 100.0, // Adjust the initial zoom level as needed
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('desired_location'),
                    position: _desiredLocation,
                    infoWindow: InfoWindow(
                      title: 'Desired Location',
                      snippet: 'This is your desired location.',
                    ),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 45,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller;
    super.dispose();
  }
}

Future<void> _launchURL(String urlString) async {
  if (await canLaunch(urlString)) {
    await launch(urlString);
  } else {
    throw 'Could not launch $urlString';
  }
}
