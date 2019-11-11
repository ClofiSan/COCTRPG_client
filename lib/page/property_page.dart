import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';

class PropertyPage extends StatefulWidget{
  PropertyPage({Key key, this.list}): super(key: key);
  final List<Widget> list;
  @override
  _PropertyPage createState() => _PropertyPage();

}


class _PropertyPage extends State<PropertyPage>{


  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child:Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: widget.list,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(

      ),



    );
  }
  
}


