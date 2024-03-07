import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Otp extends StatefulWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);

  final TextEditingController otpController;

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 70,
      child: TextFormField(
        controller: widget.otpController,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xff832729),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: '0',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xff832729),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xff832729),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(255, 66, 125, 145)),
          ),
        ),
      ),
    );
  }
}
