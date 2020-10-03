import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld_app/constants.dart';
import 'package:helloworld_app/flow.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String mobile, code, Token;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future getUser(String token) async {
    Map<String, String> headers = {"authtoken": token};
    var response = await http.get("$baseUrl/user", headers: headers);
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  void login(String mobile) {
    auth.verifyPhoneNumber(
        phoneNumber: mobile.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential result = await auth.signInWithCredential(credential);
          User user = result.user;
          if (user != null) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => BottomNav()),(Route<dynamic> route) => false
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
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
                        onChanged: (val) {
                          code = val;
                        },
                        decoration: kTextFieldDecoration,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      color: kConstBlueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onPressed: () async {
                        final code1 = code.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code1);
                        UserCredential result =
                            await auth.signInWithCredential(credential);
                        User user = result.user;
                        if (user != null) {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => BottomNav()),(Route<dynamic> route) => false
                          );
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Log In",
                style: kConstHeadingStyle,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Enter your mobile number to receive an OTP",
                style: kConstTextStyle.copyWith(fontSize: 14),
              ),
              SizedBox(
                height: 200,
              ),
              TextField(
                onChanged: (val) {
                  mobile = val;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Mobile Number"),
              ),
              SizedBox(
                height: 300,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ButtonTheme(
                  minWidth: 300,
                  height: 58,
                  child: FlatButton(
                    onPressed: () {
                      login('+91' + mobile.trim());
                    },
                    child: Text(
                      "Login",
                      style: kConstTextStyle.copyWith(
                          color: Colors.white, fontSize: 22),
                    ),
                    color: kConstBlueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    ));
  }
}
