import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:ssj/util/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class customercareinput extends StatefulWidget {
  const customercareinput({Key? key}) : super(key: key);

  @override
  State<customercareinput> createState() => _customercareinputState();
}

class _customercareinputState extends State<customercareinput> {
  TextEditingController Messages = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController Mobile = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
              child: Text(
            "Customer Care",
            style: TextStyle(
                color: Color(0xff832729),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          )),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                //To remove the keyboard when button is pressed
                FocusManager.instance.primaryFocus?.unfocus();

                var whatsappUrl = "whatsapp://send?phone=9443028832" +
                    "&text=${Uri.encodeComponent("Hello")}";
                try {
                  launch(whatsappUrl);
                } catch (e) {
                  //To handle error and display error message
                }
              },
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Column(
                    children: [
                      const Image(
                        height: 60,
                        width: 60,
                        image: AssetImage("asset/whatsapp.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CHAT",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchURL("9498810716");
              },
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Column(
                    children: [
                      const Image(
                        height: 60,
                        width: 60,
                        image: AssetImage("asset/phone.png"), // Check this path
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CALL",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
          child: Divider(
            color: Color(0xff832729),
            height: 9,
          ),
        ),
        SizedBox(
          height: 60,
          width: 310,
          child: Center(
            child: Text(
              "Contact Form Support",
              style: TextStyle(
                  fontSize: 22, color: BASECOLOR, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            controller: Name,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Name",
              label: Text(
                'Name',
                style: TextStyle(color: Colors.grey),
              ),
              fillColor: Color(0xFFF5F5F5),
              filled: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            maxLength: 10,
            controller: Mobile,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Mobile",
              label: Text(
                'Mobile',
                style: TextStyle(color: Colors.grey),
              ),
              fillColor: Color(0xFFF5F5F5),
              filled: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            maxLines: 4,
            controller: Messages,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                //borderSide:BorderSide(color: lightIconsColor),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Message",
              label: Text(
                'Message',
                style: TextStyle(color: Colors.grey),
              ),
              fillColor: Color(0xFFF5F5F5),
              filled: true,
            ),
          ),
        ),
        SizedBox(
          width: 160,
          height: 55,
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: BASECOLOR,
              ),
              onPressed: () {
                if (!Name.text.isEmpty ||
                    !Mobile.text.isEmpty ||
                    !Messages.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "loading...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  sendMail(
                      name: Name.text,
                      mobile: Mobile.text,
                      subject: Messages.text);
                } else {
                  Fluttertoast.showToast(
                      msg: "Fill all details",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  sendMail({name, mobile, subject}) async {
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    String username = 'srishanmugajewellery23@gmail.com';
    String password = 'aloi bjpq alsv dzxg';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Sri Shanmuga Jewellery!')
      ..recipients.add(username.toString())
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'New Enquiry from Mobile App '
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          """<h1>Contact form support message app</h1>\n<p>Name : $name\n<p>Mobile number :  $mobile </p>\n<p>Message : $subject</p>\n<p>Thank You!!</p>""";

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(
          msg: "Message successfully sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print('Message sent: ' + sendReport.toString());

      Name.clear();
      Mobile.clear();
      Messages.clear();
    } on MailerException catch (e) {
      Fluttertoast.showToast(
          msg: "Message not sent, Try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  _launchURL(String phoneNumber) async {
    String formattedPhoneNumber = phoneNumber.replaceAll(
        RegExp(r'\s|\+|-'), ''); // Remove spaces, plus sign, and hyphen
    String url = 'tel:$formattedPhoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
