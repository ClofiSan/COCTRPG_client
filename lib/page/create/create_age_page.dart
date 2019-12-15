import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'widget/create_title_widget.dart';
import 'widget/number_picker_widget.dart';
import 'create_occupation_skill_page.dart';
class CreateAgePage extends StatefulWidget{
  CreateAgePage({Key key, this.investigator}): super(key: key);
  final Investigator investigator;
  @override
  _CreateAgePage createState() => _CreateAgePage();

}


class _CreateAgePage extends State<CreateAgePage>{



  CreateTitleWidget _createTitleWidget;

  NumberPickerWidget _agePickerWidget;

  NumberPickerWidget _timePickerWiget;

  @override
  void initState() {
    // TODO: implement initState
    _createTitleWidget = CreateTitleWidget(title: "时代与年龄",description: "清楚调查员所处的年代和背景能帮助你更好地了解、演绎调查员",);
    _agePickerWidget = NumberPickerWidget(begin: 0,end: 100,step: 1,);
    _timePickerWiget = NumberPickerWidget(begin: 1840,end: 2020,step: 10,);
    super.initState();
  }

  Widget buildPickerContainer(Widget numberPicker,String des){
    return Container(
      margin: EdgeInsets.only(top: 50),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            color: Colors.black54,
            child: Text(des,style: TextStyle(fontSize:20,color: Colors.white ),),
          ),
          numberPicker,
        ],
      ) ,
    );
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
              buildPickerContainer(_agePickerWidget, "年龄"),
              buildPickerContainer(_timePickerWiget, "年代"),
              Container(
                margin: EdgeInsets.only(top: 120),
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                width: MediaQuery.of(context).size.width,
                child:RaisedButton(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    color: Color(0xff20BAC1),
                    child: Text("下一步",style: TextStyle(color: Colors.white,fontSize: 22),),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context)=>
                                  CreateOccupationSkillPage(
                                    investigator: widget.investigator,
                                  )
                          )
                      );
                    }
                ),
              )
            ]
          )
        )
    );
  }
  
}


