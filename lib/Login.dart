import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:chapter_3_statefull_widgets/SignUp.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'OnBoardingPage.dart';
import 'forgotPassword.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    User? user = _auth.currentUser;
    try {
      if (user != null && !user.emailVerified) {
        print(user.emailVerified);
        print('Email Not Verified');
        // Show a message to the user indicating that email is not verified
        Fluttertoast.showToast(
          msg: "Email not verified",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return; // Exit the function if email is not verified
      } else {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Only navigate to the OnBoarding screen if sign-in is successful
        Navigator.push(context, MaterialPageRoute(builder: (_) => OnBoarding()));
      }
    } catch (e) {
      // Handle login errors
      Fluttertoast.showToast(
        msg: "Login failed: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }


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
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -35,
                    height: 400,
                    width: width,
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/login.jpg'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/login.jpg'),
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
                      "Login Menu",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontFamily: 'Heading',
                      ),
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
                              keyboardAppearance: Brightness.light,
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1700),
                    child: Center(
                      child: MaterialButton(
                        onPressed: _login,
                        color: const Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        minWidth: 400,
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Color.fromRGBO(196, 135, 198, 1),
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                          "Don't have Account?",
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpPage()));
                          },
                          child: const Text(
                            "Create Account",
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
}
