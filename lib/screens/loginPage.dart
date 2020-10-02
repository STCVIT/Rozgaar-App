import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                    final code1 = code.trim();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (val){
              mobile=val;
            },
          ),
          FlatButton(onPressed: (){
            login(mobile);
          }, child: Text("Login"))
        ],
      ),
    ));
  }
}
