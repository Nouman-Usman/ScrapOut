import 'package:flutter/material.dart';
import 'OnBoardingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: OnBoarding()));
}

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const OnBoarding(),
    );
  }
}
