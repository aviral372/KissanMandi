import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kissan_mandi/Screens/authentication/phoneauth_screen.dart';
import 'package:kissan_mandi/Screens/categories/category_list.dart';
import 'package:kissan_mandi/Screens/categories/subCat_screen.dart';
import 'package:kissan_mandi/Screens/location_screen.dart';
import 'package:kissan_mandi/Screens/sellItems/seller_category_list.dart';
import 'package:kissan_mandi/Screens/sellItems/seller_subCat.dart';
import 'package:kissan_mandi/Screens/splash_screen.dart';
import 'package:kissan_mandi/forms/seller_vegetables_form.dart';
import 'package:kissan_mandi/forms/user_review_screen.dart';
import 'package:kissan_mandi/provider/cat_provider.dart';
import 'package:provider/provider.dart';

import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(

    MultiProvider(
      providers:[
        Provider(create: (_)=> CategoryProvider())

    ],
      child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.green,
          fontFamily: 'Horizon'
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        CategoryListScreen.id: (context) => CategoryListScreen(),
        SubCatList.id: (context) => SubCatList(),
        MainScreen.id: (context) => MainScreen(),
        SellerSubCatList.id: (context) => SellerSubCatList(),
        SellerCategory.id: (context) => SellerCategory(),
        SellerVegForm.id: (context) => SellerVegForm(),
        UserReviewScreen.id: (context) => UserReviewScreen(),
      },
    );
  }
}


    /*FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Colors.green,
                  fontFamily: 'Horizon'
              ),
              home: SplashScreen());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.green,
                fontFamily: 'Horizon'
            ),
            home: LoginScreen(),
            routes: {
              LoginScreen.id: (context) => LoginScreen(),
              PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
              LocationScreen.id: (context) => LocationScreen(),
            },
          );
        }
      },
    );
  }
},*/