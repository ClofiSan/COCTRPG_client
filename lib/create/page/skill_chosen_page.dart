import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/controller/SkillController.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:coc_trpg/model/SkillType.dart';
class SkillChosenPage extends StatefulWidget{
  SkillChosenPage({Key key,  this.allSkill}): super(key: key);
 final List<SkillType> allSkill;
  @override
  _SkillChosenPage createState() => _SkillChosenPage();

}

class _SkillChosenPage extends State<SkillChosenPage>{


  List<String> skillTypeList = List();
  Map<String,dynamic> skillMap = Map();
  PageController pageController;
  PageView pageView;
  int currentPage;

  @override
  void initState() {
    // TODO: implement initState
    for(var item in widget.allSkill){
      skillTypeList.add(item.skillTypeName);
      print(item.skillTypeName);
      skillMap[item.skillTypeName] = item.skillList;
    }
    pageController = PageController();
    pageView = PageView(
      controller: pageController,
      children: <Widget>[
        skillTypeSmallPage(skillMap[skillTypeList[0]]),
        skillTypeSmallPage(skillMap[skillTypeList[1]]),
        skillTypeSmallPage(skillMap[skillTypeList[2]]),
        skillTypeSmallPage(skillMap[skillTypeList[3]]),
        skillTypeSmallPage(skillMap[skillTypeList[4]]),
        skillTypeSmallPage(skillMap[skillTypeList[5]]),
        skillTypeSmallPage(skillMap[skillTypeList[6]]),
        skillTypeSmallPage(skillMap[skillTypeList[7]]),
      ],
      onPageChanged: (index){
        setState(() {
          currentPage = index;
        });
      },
    );
    super.initState();

  }

  Widget skillTypeSmallPage(List<Skill> sameSkills){
//    print(sameSkills.toString());
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
                            height: MediaQuery.of(context).size.width,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      Text(sameSkills[index].label,style: TextStyle(fontSize: 20,color: Colors.white),),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text("初始"),
                                          Text(sameSkills[index].initial.toString())
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("职业"),
                                          Text(sameSkills[index].professionalPoint.toString())
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("兴趣"),
                                          Text(sameSkills[index].interestPoint.toString())
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("总值"),
                                          Text(sameSkills[index].value.toString())
                                        ],
                                      ),
                                      Wrap(
                                        children: <Widget>[
                                          Text("描述"),
                                          sameSkills[index].description!=null?Text(sameSkills[index].description):Text("无"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.investigatorMainColor
                            ),
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
                            pageController.animateToPage(i,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
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
    return  Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
        children: <Widget>[
          buildSkillTypeButton(),
          buildSkillTableTitle(),
          Container(
            margin: EdgeInsets.fromLTRB(0,0,0,5),
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
                maxHeight: 400,
            ),
            child: pageView,
            decoration: BoxDecoration(
              color: Color(0x22000000),
            ),
          ),
        ],
      ),
    );
  }








}


