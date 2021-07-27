import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/farm.png'), fit: BoxFit.cover),
          ),

          child: Center(
              child:Text(
                  'Chat Screen',
                      style: TextStyle(color: Colors.yellow,fontWeight:FontWeight.bold,
                      fontSize: 30,),
              ),),
        ),
    );
  }
}
