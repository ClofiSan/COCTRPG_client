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
  List<int> _scrollList = List();
  ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    _begin = widget.begin;
    _end = widget.end;
    _step = widget.step;
    for(var i = _begin;i<=_end;i+=_step){
      _scrollList.add(i);
    }
    _scrollController = ScrollController(

    );
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
            gradient: RadialGradient(
                colors: [Color(0xAf20BAC1), Colors.grey],
                radius: 50,
                center: Alignment.center
            )
        ),
      child: NotificationListener(
            onNotification: (ScrollNotification note) {
              //todo : 利用状态管理进行传参
            print(note.metrics.pixels.toInt());  // 滚动位置。
          },
          child:
            ListView.builder(
              controller: _scrollController,
              itemCount: _scrollList.length,
                itemBuilder: (context,index){
                  return Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _scrollList[index].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                    alignment: Alignment.center,
                  );
                }
            )
    )
    );
  }

}
