
import '../widget/create_title_widget.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/model/Occupation.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:flutter/material.dart';
import 'package:coc_trpg/create/page/skill_point_page.dart';
import 'package:coc_trpg/controller/OccupationController.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
import '../widget/normal_input_field.dart';
import 'package:coc_trpg/controller/SkillController.dart';
import 'package:coc_trpg/model/SkillType.dart';
import 'package:coc_trpg/store/CreateInvestigatorStore.dart';
import 'package:provider/provider.dart';
import 'equipment_setting_page.dart';
import 'package:coc_trpg/model/Credit.dart';
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

  String assetsDescription;


  int _currentOccupationIndex = 0;

  int _professionalPoint = 0 ;
  int _interestingPoint = 0;
  int _sumProPoint = 0;
  int _sumIntPoint = 0;

  bool haveOccupation = false;

  var _futureBuilderFuture;

  SkillController skillController;
  OccupationController occupationController ;
  InvestigatorController investigatorController;

  List<Widget> skillTypeWidgetList;
  Widget currentSkillTypeWidget;

  int tmpInterestedPoint = 0;
  int tmpProfessionalPoint = 0;
  int tmpGrowPoint = 0;
  int interestedDiff = 0;
  int proDiff = 0;

  TextEditingController _interestedController = TextEditingController();
  TextEditingController _proController = TextEditingController();
  TextEditingController _initController = TextEditingController();
  TextEditingController _valController = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextStyle bottomSheetTitleTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 16
  );

  int creditPoint;
  Credit credit;
  Investigator investigator;



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
        hintStyle: TextStyle(fontSize: 16,color: Colors.white),
        border: InputBorder.none,
        fillColor: AppTheme.investigatorMinorColor,
        filled: true,
        errorStyle: TextStyle(color: Colors.red[600])
    );
  }

  bool isValueOrInitial(String pointType){
    return (pointType == "总值" || pointType == "初始")?true:false;
  }
  TextEditingController getTextEditingController(String pointType){
    if(pointType == "兴趣"){
      return _interestedController;
    }else if(pointType == "职业"){
     return _proController;
    }else if(pointType == "总值"){
      return _valController;
    }else{
      return _initController;
    }
  }


  Widget buildSkillPointInputWidget(String pointType,int point,Skill samSkill){
//    getTextEditingController(pointType).text = point.toString();

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
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width*0.75,
              height: 30,
              child: TextFormField(
                enabled: !isValueOrInitial(pointType),
                textAlign: TextAlign.center,
                controller: getTextEditingController(pointType),
                decoration:buildSkillPointInputDecoration(point.toString()),
                onChanged: (v){
                  setState(() {
                    if(pointType == "兴趣"){
                      tmpInterestedPoint = int.parse(v);
                      interestedDiff = tmpInterestedPoint - samSkill.interestPoint;
                    }else if(pointType == "职业"){
                      tmpProfessionalPoint = int.parse(v);
                      proDiff = tmpProfessionalPoint - samSkill.professionalPoint;
                    }else if(pointType == "总值"){

                    }
                    samSkill.value = samSkill.initial + tmpProfessionalPoint + tmpInterestedPoint;
                    if(samSkill.label == "信用评级"){
                      creditPoint = samSkill.value;
                      credit = investigatorController.getCredit(creditPoint);
                      Provider
                          .of<CreateInvestigatorStore>(context,listen: false)
                          .investigator.credit = credit;
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
  List<DropdownMenuItem<String>> buildDropdownMenuItemList(Skill skill){
    List<DropdownMenuItem<String>> list = List();
    for(var item in skill.childSkill){
      list.add(
          DropdownMenuItem<String>(
            value: item.label,
            child: Text(item.label,style: TextStyle(color: Colors.black),),
          )
      );
    }
    return list;
  }


  showSubSkillDialog(Skill skill){
    Skill _skill;
    if(skill.subSkill==null){
      _skill = skill.childSkill[0];
    }else{
      _skill = skill.subSkill;
    }
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: AppTheme.investigatorMinorColor,
            title: Text("选择子技能",style: AppTheme.dialogTextStyle,),
            content:
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                child:Container(
                  child: ListView.builder(
                      itemCount: skill.childSkill.length,
                      itemBuilder:(context,index){
                        return Container(
                          child: FlatButton(
                              onPressed: (){
                                setState(() {
                                  _skill = skill.childSkill[index];
                                  skill.subSkill = _skill;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                skill.childSkill[index].label,
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
  Widget buildSubSkillExpansionPanel(Skill skill){
    Skill _skill;
    if(skill.subSkill==null){
      _skill = skill.childSkill[0];
    }else{
      _skill = skill.subSkill;
    }
    return  Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "子技能",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width*0.75,
              height: 30,
              child:Container(
                constraints: BoxConstraints(
                  maxHeight: 50
                ),
                child: FlatButton(
                  child: Text(_skill.label),
                  onPressed: (){
                    showSubSkillDialog(skill);
                  },
                )
              )
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
                      _interestedController.text = sameSkills[index].interestPoint.toString();
                      _proController.text = sameSkills[index].professionalPoint.toString();
                      tmpInterestedPoint = sameSkills[index].interestPoint;
                      tmpProfessionalPoint = sameSkills[index].professionalPoint;
                      proDiff = 0;
                      interestedDiff = 0;
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {

                          return Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                  color: Color(0xcc20BAC1)
//                                  color:Colors.black38,
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
                                        sameSkills[index].childSkill.length == 0 ? Container():buildSubSkillExpansionPanel(sameSkills[index]),
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
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      "${sameSkills[index].value~/1} / ${sameSkills[index].value~/2} / ${sameSkills[index].value~/5}",
                                                      style: TextStyle(fontSize:16,color: Colors.white)
                                                  ),
                                                )
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
                                          width: MediaQuery.of(context).size.width,
                                          height: 100,
                                          margin: EdgeInsets.all(5),
                                          child:ListView(
                                            shrinkWrap: true,
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
                                          margin: EdgeInsets.only(top:5),
                                          child: RaisedButton(
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
                                                _interestingPoint -= interestedDiff;
                                                _professionalPoint -= proDiff;
                                                skillTypeWidgetList = loadSkillTypeWidgetList(
                                                    Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.allSkill
                                                );
                                                currentSkillTypeWidget = skillTypeWidgetList[0];
                                              });
                                              tmpProfessionalPoint = 0;
                                              tmpInterestedPoint = 0;
                                              tmpGrowPoint = 0;
//                                              _interestedController = new TextEditingController();
//                                              _proController = new TextEditingController();
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
    investigatorController = InvestigatorController();
    credit = Credit();
    await occupationController.loadAllOccupation();
    await skillController.loadSkills(widget.investigator);
    creditPoint = skillController.getCreditPoint();
    Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.credit = credit;
    occupationList = occupationController.getAllOccupationList();
    skillTypeList = skillController.getAllSkillType();
    allSkill = skillController.getAllSkill();
    credit = investigatorController.getCredit(creditPoint);
    Provider.of<CreateInvestigatorStore>(context,listen: false).changeAllSkill(allSkill);
    skillTypeWidgetList = List();
    skillTypeWidgetList = loadSkillTypeWidgetList(
        Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.allSkill
    );
    currentSkillTypeWidget = skillTypeWidgetList[0];
    currentOccupation = occupationList[0];

    _sumIntPoint = getInterestingPoint();
    _sumProPoint = getProfessionalPoint();
    Provider.of<CreateInvestigatorStore>(context,listen: false)
        .setInterestedPoint(getInterestingPoint());
    Provider.of<CreateInvestigatorStore>(context,listen: false)
        .setProPoint(getProfessionalPoint());
    _professionalPoint = Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.proPoint;
    _interestingPoint = Provider.of<CreateInvestigatorStore>(context,listen: false).investigator.interestedPoint;

    investigator =
        Provider.of<CreateInvestigatorStore>(context,listen: false).investigator;
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
    return Expanded(
      flex: 1,
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                des,
                style: TextStyle(fontSize: 16,color: Colors.black),
                textAlign: TextAlign.center,
              ),
//              margin: EdgeInsets.only(right: 5),
            ),
            Container(
              child: Text(
                point.toString(),
                style: TextStyle(fontSize: 16,color: Colors.white),
                textAlign: TextAlign.center,
              ),
//              margin: EdgeInsets.only(right: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget changeSkillTypeWidget(int index){
    return skillTypeWidgetList[index];
  }

  Widget buildSkillPointRow(){
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildSkillPointWidget("职业剩余", _professionalPoint),
        buildSkillPointWidget("兴趣剩余", _interestingPoint),
        buildSkillPointWidget("总剩余", _interestingPoint+_professionalPoint),
      ],
    );
  }

  Widget buildSumSkillPoint(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildSkillPointWidget("职业点数", _sumProPoint),
        buildSkillPointWidget("兴趣点数", _sumIntPoint),
        buildSkillPointWidget("总点数", _sumProPoint+_sumIntPoint),
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
  final TextStyle creditItemTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.white
  );
  Widget buildCreditItemContainer(String label,String value){
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: creditItemTextStyle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value,
            style: creditItemTextStyle,
          ),
        )
      ],
    );
  }
  Widget buildCreditRowContainer(List<String> credits,List<String> value){
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: buildCreditItemContainer(
              credits[0],
              value[0]
            ),
          ),
          Expanded(
            flex: 1,
            child: buildCreditItemContainer(
                credits[1],
                value[1]
            ),
          )
        ],
      ),
    );
  }
  TextEditingController assetsDescriptionController = TextEditingController();
  Widget buildCreditContainer(){
    List<Widget> list = List();
    list.add(buildCreditRowContainer(
        ["信用评级:","生活水平:"],
        [credit.creditPoint.toString(),credit.livingStandard]
    ));
    list.add(buildCreditRowContainer(
        ["现金:","消费水平:"],
        [credit.cash,credit.consumptionLevel]
    ));
    list.add(
      Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                  "资产说明",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                  child:NormalInputField(
                    controller: assetsDescriptionController,
                    hintText: "",
                    maxLine: 3,
                    validatorFunction: (v){
                      assetsDescription = v;
                    },
                    onSavedFunction: (v){
                      assetsDescription = v;
                    },
                  ),
              )
            )
          ],
        ),
      )
    );
    return Container(
      child: Column(
        children: list
      ),
    );

  }


  loadInvestigatorSkills(){
    Investigator _in = Provider
        .of<CreateInvestigatorStore>(context,listen: false)
        .investigator;
    List<Skill> skillList = List();
    for(var skills in _in.allSkill){
      for(var item in skills.skillList){
        if(item.initial < item.value){
          skillList.add(item);
          print(item.label);
        }
      }
    }
    _in.skills = skillList;
    Provider
        .of<CreateInvestigatorStore>(context,listen: false)
        .investigator = _in;
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
                description: "一个好的职业是给KP整活儿的第一步",
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
                      child:buildSumSkillPoint(),
                    ),
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
                    buildItemTitleWidget("资产情况"),
                    buildCreditContainer(),
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
//
                            Provider
                                .of<CreateInvestigatorStore>(context,listen: false)
                                .investigator.occupation = currentOccupation;

                            if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            Provider
                                .of<CreateInvestigatorStore>(context,listen: false)
                                .investigator.credit.assetsDescription = assetsDescription;
                          }
                            loadInvestigatorSkills();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>EquipmentSettingPage()
                                )
                            );

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


