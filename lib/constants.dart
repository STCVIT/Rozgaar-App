import 'package:flutter/material.dart';

const kConstFontFamily= "Spartan";

const baseUrl='https://hackthehourglass.herokuapp.com/user';

const kConstGreyColor =Color(0xffe5e5e5);
const kConstBlueColor =Color(0xff1a73e9);

const kConstHeadingStyle=TextStyle(
  fontFamily: kConstFontFamily,
  fontSize: 32,
  fontWeight: FontWeight.w600
);

const kConstTextStyle=TextStyle(
  fontFamily: kConstFontFamily,
  fontSize: 18
);

InputDecoration kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xfff1f1f1),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xfff1f1f1), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xfff1f1f1), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
);