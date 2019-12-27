import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Occupation.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
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
  List<Skill> _occupationSkillList = List();
  List<Skill> _investigatorSkillList = List();
  List<String> _choosablelist = List();

  loadSkills() async{

    var data = await rootBundle.loadString('assets/occupations.json');
    var jsonData = json.decode(data);
    for(var item in jsonData){

    }
  }

  int getProfessionalPoint(){
    int point = 0;
    point = InvestigatorController.getSkillPointByRules(_currentOccupation.skillPointRule, widget.investigator);
    return point;
  }

  int getInterestingPoint(){
    int point = 0;
    point = InvestigatorController.getInvestigatorInteresPoint(widget.investigator);
    return point;
  }

  Widget buildSkillPointWidget(String des,int point){
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              des,
              style: AppTheme.skillPointTextStyle,
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(right: 5),
          ),
          Container(
            child: Text(
              point.toString(),
              style: AppTheme.createMinorColorBoxDescribeTextStyle,
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _currentOccupation = widget.investigator.occupation;
    _investigatorSkillList = widget.investigator.skills;
    _occupationSkillList = widget.investigator.occupation.skills;
    _professionalPoint = getProfessionalPoint();
    _interestingPoint = getInterestingPoint();
    initChoosableList(_occupationSkillList);
    super.initState();
  }

  void initChoosableList(List<Skill> skillList){
    skillList.forEach((e){
      if(_isChoosableSkill(e))
        _choosablelist.add(e.label);
    });
  }
  bool _isChoosableSkill(Skill skill){
    //符号和字符串长度
    return (skill.label.contains("（") || skill.label.length >= 8)? true : false;

  }

  List<Widget> buildTitleWidget(){
    List<Widget> widgetList = List();
    widgetList.add(buildSkillPointRow());
    for(var item in _choosablelist){
      print(item);
      widgetList.add(
        Container(
          child: Text(item,style: AppTheme.skillPointTextStyle,),
        )
      );
    }
    return widgetList;
  }

  Row buildSkillPointRow(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildSkillPointWidget("职业点数", _professionalPoint),
        buildSkillPointWidget("兴趣点数", _interestingPoint),
        buildSkillPointWidget("总点数", _interestingPoint+_professionalPoint),
      ],
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
        child:Scaffold(
          backgroundColor: Colors.transparent,
          appBar:  AppBar(
            backgroundColor: Colors.transparent,
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: AppTheme.investigatorMainColorLight,
              onPressed: (){

              }
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  child: Column(
                    children: buildTitleWidget()
                  )
                ),
                Expanded(
                  child:Container(
                    margin: EdgeInsets.only(top:10),
                    width: 200,
                    child: ListView.builder(
                      itemCount: _currentOccupation.skills.length,
                      itemBuilder: (context,index){
                        if(!_isChoosableSkill(_currentOccupation.skills[index])){
                          return Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(top:10),
                                    color: AppTheme.investigatorMinorColor,
                                    child: FlatButton(
                                      onPressed:(){

                                      },
                                      child: Text(
                                        _currentOccupation.skills[index].label,
                                        style: TextStyle(fontSize: 18,color: Colors.white),
                                      ),
                                    )
                                )
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.chevron_left),
                                      onPressed: (){

                                      },
                                    ),
                                    Container(
                                      child: Text(_currentOccupation.skills[index].initial.toString()),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.chevron_right),
                                      onPressed: (){

                                      },
                                    ),

                                  ],
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  )
                )
              ],
            )
          ),
        )
    );
  }

}


