import 'package:flutter/material.dart';

class CreateTitleWidget extends StatelessWidget{
  CreateTitleWidget({Key key, this.title, this.description, }): super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(this.title,style: TextStyle(fontSize: 45),),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child:   Divider(
              thickness: 3,
              color: Colors.black,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child:   Text(
              this.description,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

}