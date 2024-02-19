import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationCode = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generateVerificationCode();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _generateVerificationCode() {
    _verificationCode = randomNumeric(6);
    // Send the verification code to the user's email address
    _sendVerificationEmail(_verificationCode);
  }

  void _sendVerificationEmail(String code) {
    // Code to send the verification code via email
    print('Verification code: $code');
    // In a real app, you would send the code to the user's email using a service like Firebase Authentication
  }

  void _startTimer() {
    const duration = Duration(seconds: 30);
    _timer = Timer(duration, () {
      // Reset the verification code after 30 seconds
      setState(() {
        _generateVerificationCode();
      });
    });
  }

  Future<void> _verifyEmail(String enteredCode) async {
    if (enteredCode == _verificationCode) {
      _timer?.cancel(); // Stop the timer
      // Mark the email as verified
      try {
        await _auth.currentUser!.reload();
        if (_auth.currentUser!.emailVerified) {
          // Email is verified
          Fluttertoast.showToast(
            msg: "Email verified successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          // Navigate to the next screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => NextScreen()),
          );
        } else {
          // Email is not verified
          Fluttertoast.showToast(
            msg: "Email verification failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } catch (e) {
        print('Error verifying email: $e');
        Fluttertoast.showToast(
          msg: "Email verification failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      // Incorrect verification code
      Fluttertoast.showToast(
        msg: "Incorrect verification code",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'A verification code has been sent to your email.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Verification Code: $_verificationCode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Enter the code below:',
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  // You can validate the entered code here if needed
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Replace 'enteredCode' with the value entered by the user
                _verifyEmail('enteredCode');
              },
              child: Text('Verify Email'),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('Email verified. You can proceed to the next screen.'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EmailVerificationPage(),
  ));
}
