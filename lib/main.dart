import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'page/role_choose_page.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
////      statusBarColor: Colors.transparent,
//      statusBarIconBrightness: Brightness.dark,
//      statusBarBrightness:
//        Platform.isAndroid ? Brightness.dark : Brightness.light,
//      systemNavigationBarColor: Colors.grey,
//      systemNavigationBarDividerColor: Colors.grey,
//      systemNavigationBarIconBrightness: Brightness.dark,
//    ));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Color(0xFF20BAC1)
      ),
      home: RoleChoosePage()
    );
  }
}

