import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helloworld_app/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:helloworld_app/constants.dart';

class GetProfile extends StatefulWidget {
  final String mobile,token;
  GetProfile({this.mobile,this.token});
  @override
  _GetProfileState createState() => _GetProfileState(this.mobile,this.token);
}

class _GetProfileState extends State<GetProfile> {
  _GetProfileState(this.phoneText,this.Token);
  TextEditingController name=TextEditingController(text: '');
  String Token;
  String phoneText;
  TextEditingController phone;
  Future setProfile()async{
    Map<String, String> headers = {"authtoken": Token,"Content-Type": "application/json",};
    var response = await http.post(
        "$baseUrl/user/",
        headers: headers,body: jsonEncode({
      "userInfo": {
        "name": name.text.trim(),
      }}));
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone=TextEditingController(text: phoneText);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phone.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) =>
           Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Enter your personal details',
                      style: kConstHeadingStyle.copyWith(fontSize: 24),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(Icons.person,color: Colors.white,size: 60,),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                TextField(
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your name',),
                  controller: name,
                ),
                SizedBox(height: 16,),
                AbsorbPointer(
                  child: TextField(
                    decoration: kTextFieldDecoration,
                    controller: phone,
                  ),
                ),
                SizedBox(height: 300,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ButtonTheme(
                      minWidth: 300,
                      height: 58,
                      child: FlatButton(onPressed: (){
                        if(setProfile()==200){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                        };
                      }, child: Text("Next",style: kConstTextStyle.copyWith(color: Colors.white,fontSize: 22),),color: kConstBlueColor,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),),
                    ),]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

