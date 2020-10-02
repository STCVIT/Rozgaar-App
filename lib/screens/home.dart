import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helloworld_app/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome,",
            style: kConstTextStyle.copyWith(
                fontSize: 16,
                color: kConstBlueColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Home",
            style: kConstHeadingStyle.copyWith(fontSize: 36),
          ),
          SizedBox(height: 12,),
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText: "Enter pin-code"),
          ),
          SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(12)),
            height: 160,
            width: 500,
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(14)),
                child: Icon(FontAwesomeIcons.car,color: Colors.white,size: 50,),
              ),
              Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(14)),
                child: Icon(FontAwesomeIcons.broom,color: Colors.white,size: 50,),
              ),
              Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(14)),
                child: Icon(FontAwesomeIcons.bolt,color: Colors.white,size: 50,),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(14)),
                child: Icon(FontAwesomeIcons.hardHat,color: Colors.white,size: 50,),
              ),
              Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(14)),
                child: Icon(FontAwesomeIcons.toilet,color: Colors.white,size: 50,),
              ),
              Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(14)),
                child: Icon(FontAwesomeIcons.hammer,color: Colors.white,size: 50,),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 120,
                height: 100,
                child: Icon(FontAwesomeIcons.lightbulb,color: Colors.white,size: 50,),
                  decoration: BoxDecoration(color: kConstBlueColor,borderRadius: BorderRadius.circular(14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
