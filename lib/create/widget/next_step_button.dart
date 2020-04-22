import 'package:flutter/material.dart';
class NextStepButton extends StatelessWidget{
  final String text;
  final onPressFunction;

  const NextStepButton({Key key, this.text, this.onPressFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 40,bottom: 40),
      width: MediaQuery.of(context).size.width,
      child:RaisedButton(
          padding: EdgeInsets.only(top: 10,bottom: 10),
          color: Color(0xff20BAC1),
          child: Text(
            "下一步",
            style: TextStyle(color: Colors.white,fontSize: 22),),
          onPressed: onPressFunction
      ),
    );
  }

}