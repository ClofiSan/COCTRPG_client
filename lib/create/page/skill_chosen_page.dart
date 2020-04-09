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

  Widget skillTypeSmallPage(sameSkills){
//    print(sameSkills.toString());
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: sameSkills.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
                child:FlatButton(
                    onPressed: (){
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 150,
//                            color: AppTheme.investigatorMinorColor,
                            child: Column(
                              children: <Widget>[
                                Text(sameSkills[index].label),
                                Text(sameSkills[index].description),
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
                      child: Flex(
                          direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(sameSkills[index].label,style: TextStyle(color: Colors.white),),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
        children: <Widget>[
          buildSkillTypeButton(),

          Container(
            margin: EdgeInsets.fromLTRB(15,5,15,5),
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


