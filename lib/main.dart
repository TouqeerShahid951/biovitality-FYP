import 'package:biovitality/ui/intro_slider_screen.dart';
import 'package:biovitality/ui/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:biovitality/ui/bottomActivities/bulletin_screen.dart';
import 'package:biovitality/ui/bottomActivities/marketview_screen.dart';
import 'package:biovitality/ui/bottomActivities/weather_screen.dart';
import 'package:biovitality/ui/bottomActivities/home_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase for Flutter

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bio Vitality',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? Home(uid: FirebaseAuth.instance.currentUser!.uid)
          : IntroSliderScreen(), // Show intro sliders only if user is logged out
      routes: {
        '/home': (context) {
          // Retrieve the current user from Firebase Authentication
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // If user is authenticated, navigate to Home with uid
            return Home(uid: user.uid);
          } else {
            // If user is not authenticated, navigate to WelcomeScreen
            return LoginScreen();
          }
        },
        '/market_view': (context) => MarketViewScreen(),
        '/weather': (context) => WeatherScreen(),
        '/bulletin': (context) => BulletinScreen(),
      },
    );
  }
}