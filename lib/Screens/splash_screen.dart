import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/Screens/location_screen.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'Splash-Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Timer(Duration(
      seconds: 3,
    ),() {
      FirebaseAuth.instance.authStateChanges().listen((User user){
        if(user == null) {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }
        else
        {
          Navigator.pushReplacementNamed(context, LocationScreen.id);
        }

      });
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      body:Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/farm.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SizedBox(
          width: 250.0,
            child: DefaultTextStyle(
            style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Horizon',
              color: Colors.yellowAccent,
            ),
              child: AnimatedTextKit(
              animatedTexts: [
                ScaleAnimatedText('Kissan Mandi  Now a click away!')
                ],
              onTap: () {
                print("Tap Event");
                },
              ),
            ),
          ),
        ),
      )
    );
  }
}
