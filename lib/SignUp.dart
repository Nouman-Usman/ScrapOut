import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';

import 'Login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedRole = 'Buyer';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 300,
                    width: width,
                    child: FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/background.png'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 300,
                    width: width + 20,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/background-2.png'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(196, 135, 198, .3)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(
                                            196, 135, 198, .3)))),
                            child: TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(
                                            196, 135, 198, .3)))),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Color.fromRGBO(
                                            196, 135, 198, .3)))),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedRole,
                              items: <String>['Buyer', 'Seller']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value!;
                                });
                              },
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 9),
                                child: Icon(Icons.arrow_circle_down_sharp),
                              ),
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Color.fromRGBO(
                                            196, 135, 198, .3)))),
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9+]')),
                                LengthLimitingTextInputFormatter(11),
                                _PhoneNumberInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Phone Number",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1900),
                    child: MaterialButton(
                      onPressed: _register,
                      color: const Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already Have Account?',
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => HomePage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// Function to handle user registration
  Future<void> _register() async {
    String errorMessage = '';
    try {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        await userCredential.user!.sendEmailVerification();
        _showErrorDialog('Verification has been sent to your Email','Attention');
        String userId = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('UserDetails').doc(userId).set({
          'username': _usernameController.text.trim(),
          'role': selectedRole,
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
          'phoneNumber': _phoneController.text.trim(),
          // Add more fields as needed
        });
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } else {
        errorMessage = "Password and Confirm Password is not same ";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An error occurred. Please try again later.';
      }
      _showErrorDialog(errorMessage,'Error');
    } catch (e) {
      String errorMessage = 'An error occurred. Please try again later.';
      _showErrorDialog(errorMessage,'Error');
    }
  }

  void _showErrorDialog(String message, String title1) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title1),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class _PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();

    // Only allow characters that match the regex pattern
    for (int i = 0; i < newValue.text.length; i++) {
      final String char = newValue.text[i];
      if (_isAllowed(char, i)) {
        newText.write(char);
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  bool _isAllowed(String char, int index) {
    // Allow digits and '+' at appropriate positions
    if (index == 0 && char == '0') {
      return true;
    } else if (index == 1 && char == '3') {
      return true;
    } else if (index > 1 && RegExp(r'[0-9]').hasMatch(char)) {
      return true;
    }
    return false;
  }
}

Future<void> addUserToFirestore({
  required String username,
  required String role,
  required String email,
  required String password,
  required String phoneNumber,
}) async {
  try {
    // Create user in Firebase Authentication
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // Get the user's UID
    String userId = userCredential.user!.uid;
    await FirebaseFirestore.instance.collection('UserDetails').doc(userId).set({
      'username': username,
      'role': role,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      // Add more fields as needed
    });
  } catch (e) {
    print('Error adding user to Firestore: $e');
    throw e; // Throw the error to handle it in UI
  }
}
//   void _showVerificationDialog() {
//     showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Verify your email'),
//         content: Text('A verification link has been sent to your email. Please verify your email before logging in.'),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }