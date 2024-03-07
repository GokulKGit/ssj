import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasswordChecker(),
    );
  }
}

class PasswordChecker extends StatefulWidget {
  @override
  _PasswordCheckerState createState() => _PasswordCheckerState();
}

class _PasswordCheckerState extends State<PasswordChecker> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Checker'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                ),
                onChanged: (value) => checkPasswordStrength(value),
                obscureText: true,
              ),
              SizedBox(height: 20),
              isStrong
                  ? Text(
                      'Strong Password!',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      'Password is not strong enough.',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
