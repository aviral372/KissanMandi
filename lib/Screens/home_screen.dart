import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:kissan_mandi/Screens/location_screen.dart';
import 'package:kissan_mandi/Screens/login_screen.dart';
import 'package:kissan_mandi/widgets/banner_widget.dart';
import 'package:kissan_mandi/widgets/category_widget.dart';
import 'package:kissan_mandi/widgets/custom_appBar.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home-Screen';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'India';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
          child: SafeArea(child: CustomAppBar())),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/farm.png'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,8.0),
            child: Column(
              children: [
                Container(
                  color: Colors.lightGreen,
                  child: Row(
                    children: [
                      Expanded(
                          child:TextField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              prefixIcon: Icon(Icons.search),
                            ),
                          ) ),
                      Icon(Icons.notifications_none),
                    ],
                  ),
                ),
                Padding(
                    padding:const EdgeInsets.fromLTRB(12,0,12,8),
                  child: Column(
                    children: [
                      BannerWidget(),
                      SizedBox(height: 10.0,),
                      CategoryWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
      )
    );
  }
}
