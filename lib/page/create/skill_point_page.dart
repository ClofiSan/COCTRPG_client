import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Occupation.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/controller/occupation_controller.dart';
import 'package:coc_trpg/model/Investigator.dart';

class SkillPointPage extends StatefulWidget{
  SkillPointPage({Key key, this.investigator}): super(key: key);
  final Investigator investigator;

  @override
  _SkillPointPage createState() => _SkillPointPage();
}


class _SkillPointPage extends State<SkillPointPage>{

  int _professionalPoint ;
  int _interestingPoint ;
  Occupation _currentOccupation;


  int getProfessionalPoint(){
    int point = 0;

    return point;
  }

  int getInterestingPoint(){
    int point = 0;

    return point;
  }


  @override
  void initState() {
    // TODO: implement initState
    _professionalPoint = getProfessionalPoint();
    _interestingPoint = getInterestingPoint();
    _currentOccupation = widget.investigator.occupation;
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
        child:Scaffold(
          backgroundColor: Colors.transparent,
          appBar:  AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Text("技能分配",style: TextStyle(fontSize: 35),),
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
                  child: Row(
                    children: <Widget>[
                      Text(
                        "职业点数",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "兴趣点数",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "总和",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )

                ),
              ],
            )
          ),
        )
    );
  }

}


