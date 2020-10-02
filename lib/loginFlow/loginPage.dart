import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld_app/constants.dart';
import 'package:helloworld_app/screens/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mobile,code;
  FirebaseAuth auth=FirebaseAuth.instance;
  void login(String mobile){
    auth.verifyPhoneNumber(phoneNumber: mobile.trim(), verificationCompleted: (PhoneAuthCredential credential)async{
     UserCredential result= await auth.signInWithCredential(credential);
     User user = result.user;
     if(user != null){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
     }
    }, verificationFailed: (FirebaseAuthException e) {
        print(e);
      }, codeSent: (String verificationId, [int forceResendingToken]) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Give the code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    onChanged: (val){
                      code=val;
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Confirm"),
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  onPressed: () async{
                    final code1 = '+91'+ code.trim();
                    AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code1);
                    UserCredential result = await auth.signInWithCredential(credential);
                    User user = result.user;
                    if(user != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                  }},
                )
              ],
            );
          }
      );
    }, codeAutoRetrievalTimeout: (String verificationId){},timeout: Duration(seconds: 30));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,40,16,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Log In",style: kConstHeadingStyle,),
            SizedBox(height: 6,),
            Text("Enter your mobile number to receive an OTP",style: kConstTextStyle.copyWith(fontSize: 14),),
            SizedBox(height: 200,),
            TextField(
              onChanged: (val){
                mobile=val;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: "Mobile Number"),
            ),
            SizedBox(height: 300,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ButtonTheme(
                minWidth: 300,
                height: 38,
                child: FlatButton(onPressed: (){
                  login(mobile);
                }, child: Text("Login",style: kConstTextStyle.copyWith(color: Colors.white),),color: kConstBlueColor,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),),
              ),]
            )
          ],
        ),
      ),
    ));
  }
}
