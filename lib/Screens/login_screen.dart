import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/Screens/location_screen.dart';
import 'package:kissan_mandi/widgets/auth_ui.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login -screen';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: Center(
            child: Text(
              'Kissan Mandi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.lightGreen,
        ),
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/farm.png'), fit: BoxFit.cover),
        ),
          child: Column(
            children: [
              Expanded(child: Container(
                child: AuthUi(),
              ))
            ],
          ),
      ),
    );
  }
}
