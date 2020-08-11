import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  LoginPage({Key key}): super(key: key);

  @override
  _LoginPage createState() => _LoginPage();

}


class _LoginPage extends State<LoginPage>{

  final List<Color> _gradientColor= [Colors.grey,Colors.black];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: TextFormField(),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _gradientColor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
    );
  }
  
}


