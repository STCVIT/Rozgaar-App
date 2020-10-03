import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helloworld_app/constants.dart';
import 'package:helloworld_app/flow.dart';
import 'package:helloworld_app/loginFlow/loginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;
  void goTo()async{
    User user = await auth.currentUser;
    if(user!=null)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNav()));
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>goTo());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom:80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(child: Image(image: AssetImage('images/logo.png'),height: 150,width: 150,)),
              SizedBox(height: 10,),
              Text('Aamdani',style: kConstHeadingStyle,)
            ],
          ),
        ),
      ),),
    );
  }
}

