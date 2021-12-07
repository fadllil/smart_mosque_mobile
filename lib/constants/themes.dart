 import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFC15050);
Color? kSecondaryColor = Colors.orange[600];
const Color bluePrimary = Color(0xFF1E88E5);
const Color blueSecondary = Color(0xFF42A5f5);
Color? grayPrimary = Colors.grey[500];
Color? graySecondary = Colors.grey[200];
Color? kTextGrey = Colors.grey[400];
Color? kTextBlack = Colors.black;
const double defaultRadius = 10;
const double dimensPadding = 10;
 AppBarTheme appBarTheme=AppBarTheme(
    brightness: Brightness.dark
);
 InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(
      color: Colors.grey[400],
      fontSize: 13),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(defaultRadius),
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0,),
  ),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(defaultRadius)),
  contentPadding: new EdgeInsets.symmetric(vertical: 15, horizontal: 8),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(defaultRadius)),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(defaultRadius)),
);