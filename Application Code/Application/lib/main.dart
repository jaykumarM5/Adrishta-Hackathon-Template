import 'package:flutter/material.dart';
import 'package:i_voted/screens/History.dart';
import 'package:i_voted/screens/HomePage.dart';
import 'package:i_voted/screens/Login.dart';
import 'package:i_voted/screens/OTPPage.dart';
import 'package:i_voted/Navigate.dart';
import 'package:i_voted/screens/AboutPage.dart';
import 'package:i_voted/screens/Splash.dart';
import 'package:i_voted/screens/AdminPage.dart';
import 'package:i_voted/screens/ElectionDisplayUser.dart';
import 'Data.dart';
import 'package:i_voted/screens/ElectionDisplay.dart';

// Main Page from where the application starts executing

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'history',
      routes: {
        'electionUser': (context) => ElectionDisplayUser(),
        'electiondisplay': (context) => ElectionDisplay(),
        'login': (context) => LoginPage(),
        'nav': (context) => Navigate(),
        'about': (context) => About(),
        'splash': (context) => Splash(),
        'history': (context) => History(),
        'home': (context) => HomePage(),
        'otp': (context) => OTPPage(),
      },
    ),
  );
}
