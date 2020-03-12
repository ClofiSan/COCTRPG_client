
import '../widget/create_title_widget.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/model/Occupation.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:flutter/material.dart';
import 'package:coc_trpg/create/page/skill_point_page.dart';
import 'package:coc_trpg/controller/OccupationController.dart';
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

  int _currentOccupationIndex = 0;
  loadOccupations() async{
    List<Occupation> _occupationList = List();
    var data = await OccupationController.getAllOccupation();
//    var jsonData = json.decode(data);
    for(var item in data){
      Occupation occupation = Occupation();
      occupation.id = item["occupation_id"];
      occupation.name = item["occupation_name"];
      occupation.skillPointRule = item["skill_points_rule"];
      occupation.skillList = item["skill_list"];
      occupation.minCredit = item["min_credit"];
      occupation.maxCredit = item["max_credit"];
      _occupationList.add(occupation);
    }
    occupationList = _occupationList;
  }

  @override
  void initState(){
    super.initState();
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
//                Navigator.push(context,
//                    new MaterialPageRoute(builder: (context) => new OccupationListPage(
//                      occupationList: occupationList,
//                      currentOccupationIndex: _currentOccupationIndex,
//                    )));
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
      currentOccupation = occupationList[0];
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
                    Container(
                      margin: EdgeInsets.only(top: 40,bottom: 40),
                      width: MediaQuery.of(context).size.width,
                      child:RaisedButton(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          color: Color(0xff20BAC1),
                          child: Text("下一步",style: TextStyle(color: Colors.white,fontSize: 22),),
                          onPressed: (){
                            widget.investigator.occupation = occupationList[_currentOccupationIndex];
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context)=>
                                        SkillPointPage(investigator: widget.investigator,)
                                )
                            );
                          }
                      ),
                    )
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
              future: loadOccupations(),
            )
        )
    );
  }

}


