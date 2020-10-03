import 'package:flutter/material.dart';
import 'package:helloworld_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  _launchURL() async {
    const url = 'https://www.pmcares.gov.in/en/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(onPressed:_launchURL,label: Text('Donate to PM Cares',style: kConstTextStyle.copyWith(fontSize: 16),),backgroundColor: kConstBlueColor,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Us",
                style: kConstHeadingStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Wanna know more about us?",
                style: kConstTextStyle.copyWith(fontSize: 14),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    child: Image(image: AssetImage('images/logo.png')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aamdani",style: kConstHeadingStyle.copyWith(fontSize: 26),),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Aamdani is a humble app that aims to bring employment to the poorest of the poor of our country who dont have Whatsapp or Linkedin or even a smartphone for that matter of fact to search for jobs.",
                style: kConstTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Your smallest contribution can save millions of innocent lives. Every small contribution counts . We are all in this together !",
                  style: kConstTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}
