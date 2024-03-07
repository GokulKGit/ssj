import 'package:flutter/material.dart';
import 'package:ssj/screen/home/drawer_pages/privacy_policy_input.dart';
import 'package:ssj/util/constant.dart';

class Retrunpolicy extends StatefulWidget {
  const Retrunpolicy({Key? key}) : super(key: key);

  @override
  State<Retrunpolicy> createState() => _RetrunpolicyState();
}

class _RetrunpolicyState extends State<Retrunpolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(),
        backgroundColor: Color(0xff832729),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Color(0xff832729),
                radius: 0, // Image radius
                backgroundImage: AssetImage('asset/logo.png'),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xff832729),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Return Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Builder(builder: (context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  """ This Privacy Policy explains how we collect, use, and share your personal information when you use our Application (the "Application").""",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """What information do we collect?""",
                                  style: TextStyle(
                                      color: BASECOLOR,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """We collect the following personal information from you when you use the Application:""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """Contact information, such as your name, email address, and phone number.Financial information, such as your bank account number and PAN number, Gold purchase history.
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """How do we use your information?""",
                                  style: TextStyle(
                                      color: BASECOLOR,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """We use your information to:
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """Provide you with the services you request through the Application. Process your payments and redemptions of your gold purchases. Communicate with you about your account and the Application. Send you marketing and promotional materials. Improve our services and the Application. Comply with legal and regulatory requirements""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """How do we share your information?""",
                                  style: TextStyle(
                                      color: BASECOLOR,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """We share your information with the following third parties:
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """Our service providers, who help us to provide and improve the Application and the services we offer. Financial institutions, to process your gold purchases. Law enforcement and other government agencies, if required by law
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """Your choices""",
                                  style: TextStyle(
                                      color: BASECOLOR,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """You have the following choices regarding your personal information:
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """You can choose to opt out of receiving marketing and promotional materials from us by following the instructions in the emails or other communications we send you.
You can access and update your personal information by logging into your account on the Application.
You can request that we delete your personal information by contacting us at omalurssjcustomercare@gmail.com
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """Data security""",
                                  style: TextStyle(
                                      color: BASECOLOR,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure. However, no method of data transmission or storage is 100% secure.
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """Changes to this Privacy Policy""",
                                  style: TextStyle(
                                      color: BASECOLOR,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """We may update this Privacy Policy from time to time. If we make any material changes, we will notify you by posting the updated Privacy Policy on the Application or by sending you an email.
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  """Contact us""",
                                  style: TextStyle(
                                      color: BASECOLOR,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  """
If you have any questions about this Privacy Policy, please contact us at omalurssjcustomercare@gmail.com.
""",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ));
                }),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
