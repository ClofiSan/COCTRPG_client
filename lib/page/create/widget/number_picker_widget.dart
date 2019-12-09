import 'package:flutter/material.dart';

/*
* 输入：begin,end,step
* */


class NumberPickerWidget extends StatefulWidget{
  NumberPickerWidget({Key key, this.begin, this.end, this.step}): super(key: key);
  final int begin;
  final int end;
  final int step;

  @override
  _NumberPickerWidget createState() => _NumberPickerWidget();

}


class _NumberPickerWidget extends State<NumberPickerWidget>{

  int _begin;
  int _end;
  int _step;
  double _length;
  @override
  void initState() {
    // TODO: implement initState
    _begin = widget.begin;
    _end = widget.end;
    _step = widget.step;
    _length = (_end - _begin) / _step;
    print(_length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      constraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 150
      ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xbb20BAC1), Colors.grey],
                begin: Alignment.center,
                end: Alignment.bottomLeft
            )
        ),
      child: ListView.builder(
        itemCount: _length.toInt(),
          itemBuilder: (context,index){
            return Container(

              child: Text(index.toString(),style: TextStyle(fontSize: 40),),
            );
          }
      )
    );
  }

}
