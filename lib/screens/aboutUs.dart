import 'package:flutter/material.dart';
import 'package:helloworld_app/constants.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) =>
         Padding(
          padding: const EdgeInsets.fromLTRB(16,24,16,16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About Us",style: kConstHeadingStyle.copyWith(fontSize: 36),),
              SizedBox(height: 8,),
              Text("Wanna know more about us?",style: kConstTextStyle.copyWith(fontSize: 14),),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Text("Rozgar is a humble app that aims to bring employment to the poorest of the poor of our country who dont have Whatsapp or Linkedin or even a smartphone for that matter of fact to search for jobs.",style: kConstTextStyle,),
              SizedBox(height: 20,),
              Text("Your smallest contribution can save millions of innocent lives. Every small contribution counts . We are all in this together !",style: kConstTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}
