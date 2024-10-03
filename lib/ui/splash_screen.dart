import 'dart:async';

import 'package:biovitality/ui/user_login_screen.dart';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: Image.asset(
              'assets/images/logo.png', // Adjust the path to your logo image
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
