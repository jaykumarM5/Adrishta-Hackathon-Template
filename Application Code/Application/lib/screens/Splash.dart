import 'package:flutter/material.dart';
import 'dart:async';
import 'package:i_voted/Data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    // fetches if email and role of the user is stores or not ie he is logged in or not
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.get("email") != null ? prefs.get("email") : '';
    role = prefs.get("role") != null ? prefs.get("role") : '';
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // if the role of the user is admin then it will redirect the user to the admin page
    print(role);
    if (role == 'admin') {
      Navigator.of(context)
          .pushReplacementNamed(email.isEmpty ? 'login' : 'electiondisplay');
    } else {
      Navigator.of(context)
          .pushReplacementNamed(email.isEmpty ? 'login' : 'nav');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  'I V',
                  style: TextStyle(
                    fontFamily: 'Piedra',
                    fontSize: 150,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'O T E D',
                  style: TextStyle(
                      fontFamily: 'Piedra', fontSize: 15, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
