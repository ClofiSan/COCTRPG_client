import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'widget/create_title_widget.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'widget/number_picker_widget.dart';
class CreateAgePage extends StatefulWidget{
  CreateAgePage({Key key, this.investigator}): super(key: key);
  final Investigator investigator;
  @override
  _CreateAgePage createState() => _CreateAgePage();

}


class _CreateAgePage extends State<CreateAgePage>{



  CreateTitleWidget _createTitleWidget;

  NumberPickerWidget _agePickerWidget;

  @override
  void initState() {
    // TODO: implement initState
    _createTitleWidget = CreateTitleWidget(title: "时代与年龄",description: "清楚调查员所处的年代和背景能帮助你更好地了解、演绎调查员",);
    _agePickerWidget = NumberPickerWidget(begin: 0,end: 100,step: 1,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xbb20BAC1), Colors.grey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar:  AppBar(
            backgroundColor: Colors.transparent,
          ),
          body:Column(
            children: <Widget>[
              _createTitleWidget,
              _agePickerWidget,
            ]
          )
        )
    );
  }
  
}


