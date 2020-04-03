import 'package:flutter/material.dart';
import 'package:coc_trpg/AppThemeData.dart';
class SmallDialogWidget extends StatefulWidget{
  SmallDialogWidget({Key key, this.title, this.list}): super(key: key);
  final String title;
  final List<dynamic> list;

  @override
  _SmallDialogWidget createState() => _SmallDialogWidget();

}


class _SmallDialogWidget extends State<SmallDialogWidget>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      backgroundColor: AppTheme.investigatorMinorColor,
      title: Text("选择职业",style: AppTheme.dialogTextStyle,),
      content:
      Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
      ),

    );
  }

}


