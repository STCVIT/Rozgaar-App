import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helloworld_app/constants.dart';
import 'package:helloworld_app/screens/searchResults.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> workers = [
    'Driver',
    'Maid',
    'Electrician',
    'Labourer',
    'Plumber',
    'Carpenter',
    'Electrician'
  ];
  final pinCode = TextEditingController(text: '');
  int randomNumber;
  Random random = new Random();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomNumber = random.nextInt(6);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => Padding(
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
                style: kConstHeadingStyle,
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Enter pin-code"),
                controller: pinCode,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: kConstBlueColor,
                    borderRadius: BorderRadius.circular(12)),
                height: 160,
                width: 500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'The most searched worker is',
                      style: kConstHeadingStyle.copyWith(
                          color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      workers[randomNumber],
                      style: kConstHeadingStyle.copyWith(
                          color: Colors.white, fontSize: 40),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResults(
                                    skill: "driver",
                                    pincode: pinCode.text,
                                  )));
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Icon(
                        FontAwesomeIcons.car,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResults(
                                    skill: "maid",
                                    pincode: pinCode.text,
                                  )));
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Icon(
                        FontAwesomeIcons.broom,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResults(
                                    skill: "electrician",
                                    pincode: pinCode.text,
                                  )));
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Icon(
                        FontAwesomeIcons.bolt,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResults(
                                      skill: "labourer",
                                      pincode: pinCode.text,
                                    )));
                      },
                      child: Container(
                        width: 120,
                        height: 100,
                        decoration: BoxDecoration(
                            color: kConstBlueColor,
                            borderRadius: BorderRadius.circular(14)),
                        child: Icon(
                          FontAwesomeIcons.hardHat,
                          color: Colors.white,
                          size: 50,
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResults(
                                    skill: "plumber",
                                    pincode: pinCode.text,
                                  )));
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Icon(
                        FontAwesomeIcons.toilet,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResults(
                                    skill: "carpenter",
                                    pincode: pinCode.text,
                                  )));
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Icon(
                        FontAwesomeIcons.hammer,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 6,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResults(
                                    skill: "guard",
                                    pincode: pinCode.text,
                                  )));
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      child: Icon(
                        FontAwesomeIcons.trafficLight,
                        color: Colors.white,
                        size: 50,
                      ),
                      decoration: BoxDecoration(
                          color: kConstBlueColor,
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
