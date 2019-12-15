import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import './widget/create_title_widget.dart';
import 'package:coc_trpg/utils/config.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/model/Occupation.dart';
class CreateOccupationSkillPage extends StatefulWidget{
  CreateOccupationSkillPage({Key key, this.investigator}): super(key: key);
  final Investigator investigator;
  @override
  _CreateOccupationSkillPage createState() => _CreateOccupationSkillPage();

}


class _CreateOccupationSkillPage extends State<CreateOccupationSkillPage>{

  String _occupationName = "考古学家";
  List<Widget> skillWidgetList = List() ;
  List<Skill> skillList = List();

  TextStyle _descriptionTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white
  );

  @override
  void initState(){

    super.initState();
  }
  List<Widget> buildSkillWidget(List<Skill> skills){
    List<Widget> skillList = List();
    for(var skill in skills){
      skillList.add(
          new FlatButton(
            onPressed: (){

            },
            child: Text(
              skill.label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
              ),
            ),
          )
      );
    }
    return skillList;
  }


  Widget buildItemTitleWidget(String title){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:20),
      color: Colors.black54,
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      constraints: BoxConstraints(
        maxWidth: 140,
      ),
      child:Text(
        title,
        style: TextStyle(
            fontSize:20,
            color: Colors.white
        ),
      ) ,
    );
  }

  List<Widget> occupationWidgetList(List<Occupation> list){
    List<Widget> widgetList = List();
    for(var item in list){
      widgetList.add(
        new Container(
          child: FlatButton(
              onPressed: (){
                skillList = item.skills;
              },
              child: Text(item.name)
          ),
        )
      );
    }
    return widgetList;
  }

  void showOccupationListDialog(BuildContext context){
    List<Occupation> occupationList = List();

    showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("选择职业"),
            children: <Widget>[
              Container(
                child: ListView(
                  children: <Widget>[

                  ],
                ),
              ),
              SimpleDialogOption(
                child: const Text("选择"),
                onPressed: (){

                },
              )
            ],
          );
        }
    );
  }

  Widget buildAttributionContainer(String des){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 30),
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      color: Colors.black54,
      child: Text(des,style: TextStyle(fontSize:20,color: Colors.white ),),
    );
  }

  Widget buildOccupationChosenButton(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
//      constraints: BoxConstraints(
//          maxHeight: 50,
//          maxWidth: 150
//      ),
      decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [Color(0xAf20BAC1), Colors.grey],
              radius: 50,
              center: Alignment.center
          )
      ),
      child:Container(
          padding: EdgeInsets.all(10),
          height: 50,
          child: FlatButton(
            onPressed: (){

            },
            child: Text(
              _occupationName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          )
      ),
    );
  }

  Widget buildOccupationChooseContainer(String des,Widget button){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child:Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: buildAttributionContainer(des),
          ),
          Expanded(
            flex: 1,
            child:  button,
          ),
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
            body:Container(
              child: ListView(
                  children: <Widget>[
                    CreateTitleWidget(
                      title: "职业与技能",
                      description: "调查员不同的职业所对应的职业各有不同，需注意技能点的消耗",
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                      color: Colors.red,
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                          maxWidth: 100
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildItemTitleWidget("职业"),
                          buildOccupationChosenButton(),
                          buildItemTitleWidget("职业技能"),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                            color: AppConfig.investigatorMinorColor,
                            constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width
                            ),
                            child: Wrap(
                              spacing: 15.0, // 主轴(水平)方向间距
                              runSpacing: 15.0, // 纵轴（垂直）方向间距
                              alignment: WrapAlignment.start,
                              children: <Widget>[
                                Text(
                                  "调查",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                  ),
                                ),
                                Text("调查",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),),
                                Text("调查",style: _descriptionTextStyle,),
                              ],
                            ),
                          ),
                          buildItemTitleWidget("详细描述"),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                            color: AppConfig.investigatorMinorColor,
                            constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width
                            ),
                            child: Text("详细详细详细详细详细详细详细详细详细",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                                )
                            )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            width: MediaQuery.of(context).size.width,
                            child:RaisedButton(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                color: Color(0xff20BAC1),
                                child: Text("下一步",style: TextStyle(color: Colors.white,fontSize: 22),),
                                onPressed: (){

                                }
                            ),
                          )
                        ],
                      ),
                    ),

                  ]
              ),
            )
            )
    );
  }

}


