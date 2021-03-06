import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kissan_mandi/Screens/authentication/google_auth.dart';
import 'package:kissan_mandi/Screens/authentication/phoneauth_screen.dart';
import 'package:kissan_mandi/services/phoneauth_service.dart';
import '../Screens/authentication/google_auth.dart';

class AuthUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow
              ),
                onPressed: (){
                Navigator.pushNamed(context, PhoneAuthScreen.id);
                }, child: Row(
                children: [
                  Icon(Icons.phone_android_outlined, color: Colors.black,),
                  SizedBox(width: 8,),
                  Text('Continue with phone', style: TextStyle(color: Colors.green[900]),)
              ],
            )),
          ),
          SignInButton(
          Buttons.Google, text: ('Continue with Google'), onPressed: ()async{
            User user = await GoogleAuthentication.signInWithGoogle(context: context);
            if(user!=null)
              {
                PhoneAuthService _authentication = PhoneAuthService();
                _authentication.addUser(context, user.uid);
              }
          },
          ),
          SignInButton(
            Buttons.FacebookNew, text: ('Continue with Google'), onPressed: (){},
          ),
          Padding(padding: const EdgeInsets.all(8.0),
            child: Text('OR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
          ),
          Padding(padding: const EdgeInsets.all(8.0),
              child: Text('Login With Email', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)
          ),
        ],
      ),
    );
  }
}
