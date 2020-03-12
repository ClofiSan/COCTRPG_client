import 'package:flutter/material.dart';
class AppTheme {

  static TextStyle createBaseInfoHintStyle = TextStyle(
      fontSize: 22,
      color: Colors.grey
  );

  static TextStyle createMinorColorBoxDescribeTextStyle = TextStyle(
      fontSize: 18,
      color: Colors.white
  );


  static TextStyle skillPointTextStyle = TextStyle(
      fontSize: 18,
      color:Colors.black
  );

  static TextStyle dialogTextStyle = TextStyle(
      fontSize: 18,
      color: Colors.white
  );

  static Color investigatorMainColor = Color(0xbb20BAC1);

  static Color investigatorMainColorLight = Color(0xff20BAC1);

  static Color investigatorMinorColor = Color(0x22000000);


  //color
  static final Map<String,List<Color>> themeColorGradient = {
    "PL":[Color(0xDd20BAC1), Colors.grey],
    "KP":[Colors.grey,Colors.white]
  } ;
}