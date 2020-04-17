
import '../widget/create_title_widget.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/model/Occupation.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:flutter/material.dart';
import 'package:coc_trpg/create/page/skill_point_page.dart';
import 'package:coc_trpg/controller/OccupationController.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
import 'package:coc_trpg/create/page/skill_chosen_page.dart';
import 'package:coc_trpg/controller/SkillController.dart';
import 'package:coc_trpg/model/SkillType.dart';
import 'package:coc_trpg/store/CreateInvestigatorStore.dart';
import 'package:provider/provider.dart';
class CreateOccupationSkillPage extends StatefulWidget{
  CreateOccupationSkillPage({Key key, this.investigator}): super(key: key);
  final Investigator investigator;
  @override
  _CreateOccupationSkillPage createState() => _CreateOccupationSkillPage();

}

class _CreateOccupationSkillPage extends State<CreateOccupationSkillPage>{

  Occupation currentOccupation = Occupation();
  List<Widget> skillWidgetList = List() ;
  List<Skill> skillList = List();
  List<Occupation> occupationList = List();
  List<String> skillTypeList = List();
  Map<String,dynamic> skillMap = Map();
  List<SkillType> allSkill = List();

  int _currentOccupationIndex = 0;

  int _professionalPoint = 0 ;
  int _interestingPoint = 0;

  bool haveOccupation = false;

  var _futureBuilderFuture;

  SkillController skillController;
  OccupationController occupationController ;

  List<Widget> skillTypeWidgetList;
  Widget currentSkillTypeWidget;

  int tmpInterestedPoint = 0;
  int tmpProfessionalPoint = 0;
  int tmpGrowPoint = 0;

  final TextStyle bottomSheetTitleTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 16
  );


  List<Widget> loadSkillTypeWidgetList(List<SkillType> skillTypeList){
    List<Widget> widgetList = List();
    for(var skillType in skillTypeList){
      widgetList.add(loadSkillTypeWidget(skillType.skillList));
    }
    return widgetList;
  }

  InputDecoration buildSkillPointInputDecoration(String hintText){
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16,color: Colors.grey),
        border: InputBorder.none,
        fillColor: AppTheme.investigatorMinorColor,
        filled: true,
        errorStyle: TextStyle(color: Colors.red[600])
    );
  }

  bool isValueOrInitial(String pointType){
    return (pointType == "总值" || pointType == "初始")?true:false;
  }

  Widget buildSkillPointInputWidget(String pointType,int point,samSkill){
    return  Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              pointType,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: MediaQuery.of(context).size.width*0.75,
              height: 30,
              child: TextField(
                enabled: !isValueOrInitial(pointType),
                textAlign: TextAlign.center,
                decoration:buildSkillPointInputDecoration(point.toString()),
                onChanged: (v){

                },
                onSubmitted: (v){
                  setState(() {
                    if(pointType == "兴趣"){
                      print(v);
                      tmpInterestedPoint = int.parse(v);
                      samSkill.value += tmpInterestedPoint;
                      print(samSkill.value);
                    }else if(pointType == "职业"){
                      tmpProfessionalPoint = int.parse(v);
                      samSkill.value += tmpProfessionalPoint ;
                    }else if(pointType == "总值"){

                    }

                  });
                },
              ),
            ),

          ),

        ],
      ),
    );
  }

  Widget loadSkillTypeWidget(List<Skill> sameSkills){
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: sameSkills.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
                child:FlatButton(
                    onPressed: (){
                      if(sameSkills[index].childSkill.length!=0){
                      }
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                            return Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                                decoration: BoxDecoration(
                                  color:Colors.black38,
//                                    gradient: LinearGradient(
//                                      colors: [Color(0xFF20BAC1), Colors.grey[600]],
//                                      begin: Alignment.topCenter,
//                                      end: Alignment.bottomCenter,
//                                    )
                                ),
                                height: MediaQuery.of(context).size.height*0.8,
                                child: Form(
                                    child:Column(
                                      children: <Widget>[
                                        Text(sameSkills[index].label,style: TextStyle(fontSize: 20,color: Colors.white),),
                                        buildSkillPointInputWidget("初始",sameSkills[index].initial,sameSkills[index]),
                                        buildSkillPointInputWidget("职业",sameSkills[index].professionalPoint,sameSkills[index]),
                                        buildSkillPointInputWidget("兴趣",sameSkills[index].interestPoint,sameSkills[index]),
                                        buildSkillPointInputWidget("总值",sameSkills[index].value,sameSkills[index]),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                          alignment: Alignment.center,
                                          child: Flex(
                                            direction: Axis.horizontal,
                                            children: <Widget>[
                                              Expanded(
                                                flex:1,
                                                child: Text(
                                                  "判定",
                                                  style: bottomSheetTitleTextStyle,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    "${sameSkills[index].value/1}/${sameSkills[index].value/2}/${sameSkills[index].value/5}",
                                                    style: TextStyle(color: Colors.white)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                          alignment: Alignment.center,
                                          child: Flex(
                                            direction: Axis.horizontal,
                                            children: <Widget>[
                                              Expanded(
                                                flex:1,
                                                child: Text(
                                                  "描述",
                                                  style: bottomSheetTitleTextStyle,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container()
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          child: Wrap(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.all(10),
                                                color: AppTheme.investigatorMinorColor,
                                                child: sameSkills[index].description!=null?
                                                Text(
                                                  sameSkills[index].description,
                                                  style: TextStyle(color: Colors.white),)
                                                    :Text("无"),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(top:20),
                                          child: FlatButton(
                                            color: AppTheme.investigatorMainColor,
                                            child: Container(
                                              child: Text(
                                                  "确定",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20
                                                ),
                                              ),
                                            ),
                                            onPressed: (){
                                              Provider.of<CreateInvestigatorStore>(context,listen: false).changeSkillValue(
                                                  sameSkills[index].label,
                                                  tmpProfessionalPoint,
                                                  tmpInterestedPoint,
                                                  tmpGrowPoint
                                              );
                                              setState((){
                                                _interestingPoint -= tmpInterestedPoint;
                                                _professionalPoint -= tmpProfessionalPoint;
                                                skillTypeWidgetList = loadSkillTypeWidgetList(
                                                    Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.allSkill
                                                );
                                                currentSkillTypeWidget = skillTypeWidgetList[0];
                                              });
                                              tmpProfessionalPoint = 0;
                                              tmpInterestedPoint = 0;
                                              tmpGrowPoint = 0;

                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                )
                            );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(sameSkills[index].label,style: TextStyle(color: Colors.white),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(sameSkills[index].initial.toString(),style: TextStyle(color: Colors.white),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(sameSkills[index].professionalPoint.toString(),style: TextStyle(color: Colors.white),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(sameSkills[index].interestPoint.toString(),style: TextStyle(color: Colors.white),),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(sameSkills[index].value.toString(),style: TextStyle(color: Colors.white))
                          )
                        ],
                      ),
                    )
                )
            );
          }
      ),
    );
  }


  int getProfessionalPoint(){
    int point = 0;
    point = InvestigatorController.getSkillPointByRules(currentOccupation.skillPointRule, widget.investigator);
    return point;
  }

  int getInterestingPoint(){
    int point = 0;
    point = InvestigatorController.getInvestigatorInteresPoint(widget.investigator);
    return point;
  }


  Future loadOccupationsAndSkills() async{
    skillController = SkillController();
    occupationController = OccupationController();
    await occupationController.loadAllOccupation();
    await skillController.loadSkills(widget.investigator);
    occupationList = occupationController.getAllOccupationList();

    skillTypeList = skillController.getAllSkillType();
    allSkill = skillController.getAllSkill();
    Provider.of<CreateInvestigatorStore>(context,listen: false).changeAllSkill(allSkill);
    skillTypeWidgetList = List();
    skillTypeWidgetList = loadSkillTypeWidgetList(
        Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.allSkill
    );
    currentSkillTypeWidget = skillTypeWidgetList[0];
    currentOccupation = occupationList[0];

    Provider.of<CreateInvestigatorStore>(context,listen: false)
        .setInterestedPoint(getInterestingPoint());
    Provider.of<CreateInvestigatorStore>(context,listen: false)
        .setProPoint(getProfessionalPoint());
    _professionalPoint = Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.proPoint;
    _interestingPoint = Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.interestedPoint;

  }

  @override
  void initState(){
    super.initState();
    _futureBuilderFuture = loadOccupationsAndSkills();
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

  Widget buildAttributionContainer(String des){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 30),
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      color: Colors.black54,
      child: Text(des,style: TextStyle(fontSize:20,color: Colors.white ),),
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

  Widget buildSkillList(String skillList){
    return Text(skillList,style: AppTheme.createMinorColorBoxDescribeTextStyle,);
  }
  Widget buildSkillPointRule(String skillPointRule){
    String str = skillPointRule.replaceAll("\n", " ");
    return Text(str,style: AppTheme.createMinorColorBoxDescribeTextStyle,);
  }
  Widget buildContentContainer(Widget widget){
    return Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        color: AppTheme.investigatorMinorColor,
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width
        ),
        child:  widget
    );
  }



  Widget buildSkillPointWidget(String des,int point){
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              des,
              style: TextStyle(fontSize: 16,color: Colors.black),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(right: 5),
          ),
          Container(
            child: Text(
              point.toString(),
              style: TextStyle(fontSize: 16,color: Colors.white),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
        ],
      ),
    );
  }

  Widget changeSkillTypeWidget(int index){
    return skillTypeWidgetList[index];
  }

  Widget buildSkillPointRow(){
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
  Widget buildSkillTypeButton(){
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: AppTheme.investigatorMinorColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: skillTypeList.map(
                    (String skillType)=>Container(
                  child: FlatButton(
                      onPressed: (){
                        for(int i=0;i<skillTypeList.length;i++){
                          if(skillTypeList[i] == skillType){
                            setState(() {
                              currentSkillTypeWidget = changeSkillTypeWidget(i);
                            });
                          }
                        }
                      }, child: Text(skillType,style: TextStyle(fontSize: 16,color: Colors.white),)),
                )
            ).toList()
        ),
      ),
    );
  }
  Widget buildSkillTableTitle(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(left: 15,right: 15),
      color: AppTheme.investigatorMinorColor,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text("技能名",style: TextStyle(color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text("初始",style: TextStyle(color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text("职业",style: TextStyle(color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text("兴趣",style: TextStyle(color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text("总值",style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    showOccupationDialog(BuildContext context){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              backgroundColor: AppTheme.investigatorMinorColor,
              title: Text("选择职业",style: AppTheme.dialogTextStyle,),
              content:
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child:Container(
                    child: ListView.builder(
                        itemCount: occupationList.length,
                        itemBuilder:(context,index){
                          return Container(
                            color: index == _currentOccupationIndex?AppTheme.investigatorMainColor:null,
                            child: FlatButton(
                                onPressed: (){
                                  setState(() {
                                    _currentOccupationIndex = index;
                                    haveOccupation = false;
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text(
                                  occupationList[index].name,
                                  style:AppTheme.dialogTextStyle,
                                )
                            ),
                          );
                        }
                    ),
                  )
              ),

            );
          }
      );
    }

    Widget buildOccupationChosenButton(){
      return Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,

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
                showOccupationDialog(context);
              },
              child: Text(
                occupationList[_currentOccupationIndex].name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
            )
        ),
      );
    }


    Widget buildMainListWidget(){

      return Container(
        child: ListView(
            children: <Widget>[
              CreateTitleWidget(
                title: "职业与技能",
                description: "不同的职业所对应的技能点各不同",
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
                    buildContentContainer(buildSkillList(occupationList[_currentOccupationIndex].skillList)),
                    buildItemTitleWidget("技能点"),
                    buildContentContainer(buildSkillPointRule(occupationList[_currentOccupationIndex].skillPointRule)),
                    buildItemTitleWidget("技能选择"),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child:buildSkillPointRow(),
                    ),
                    buildSkillTypeButton(),
                    buildSkillTableTitle(),
                    Container(
                        margin: EdgeInsets.fromLTRB(0,0,0,5),
                        width: MediaQuery.of(context).size.width,
                        constraints: BoxConstraints(
                          maxHeight: 400,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0x22000000),
                        ),
                      child: currentSkillTypeWidget
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40,bottom: 40),
                      width: MediaQuery.of(context).size.width,
                      child:RaisedButton(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          color: Color(0xff20BAC1),
                          child: Text(
                            "下一步",
                            style: TextStyle(color: Colors.white,fontSize: 22),),
                          onPressed: (){
                            currentOccupation = occupationList[_currentOccupationIndex];
                            widget.investigator.occupation = currentOccupation;
                            setState(() {
                              haveOccupation = true;
                            });

                          }
                      ),
                    ),
                  ],
                ),
              ),
            ]
        ),
      );
    }


    Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot){
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          print('none');
          return Text('ConnnectionState.none');
        case ConnectionState.active:
          print('active');
          return Text('ConnectionState.active');
        case ConnectionState.waiting:
          print('waiting');
          return Center(
            child: CircularProgressIndicator(),
          );
        case ConnectionState.done:
          print('done');
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return buildMainListWidget();
        default:
          return null;
      }
    }
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
            body:FutureBuilder(
                builder: _buildFuture,
              future: _futureBuilderFuture,
            )
        )
    );
  }

}


