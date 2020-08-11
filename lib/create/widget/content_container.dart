import 'package:flutter/material.dart';
import 'package:coc_trpg/AppThemeData.dart';
class ContentContainer extends StatefulWidget{
  ContentContainer({Key key, this.widget}): super(key: key);
  final Widget widget;
  @override
  _ContentContainer createState() => _ContentContainer();

}


class _ContentContainer extends State<ContentContainer>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(top: 15),
        color: AppTheme.investigatorMinorColor,
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width
        ),
        child: widget.widget
    );
  }

}


