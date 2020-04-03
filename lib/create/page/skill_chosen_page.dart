import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/controller/SkillController.dart';
import 'package:coc_trpg/AppThemeData.dart';
class SkillChosenPage extends StatefulWidget{
  SkillChosenPage({Key key}): super(key: key);

  @override
  _SkillChosenPage createState() => _SkillChosenPage();

}


class _SkillChosenPage extends State<SkillChosenPage>{


  List<String> skillTypeList = List();
  Map<String,dynamic> skillMap = Map();
  ExpansionPanelList _expansionPanelList = ExpansionPanelList();
  List<bool> skillExpansionSwitch = [false,false,false,false,false,false,false,false];
  TabController tabController ;
  TabBar tabbar;
  PageController pageController;
  PageView pageView;
  int currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  //tab相关内容
  TabBar getSkillTypeTabBar(){
    List<Widget> tabBarWidgetList = List();
    for(var skillType in skillTypeList){
      tabBarWidgetList.add(
        Tab(
          child: Text(skillType),
        )
      );
    }
    return TabBar(
      tabs:tabBarWidgetList,
      controller: tabController,
      isScrollable: true,
    );
  }

  TabBarView getSkillTypeTabBarView(){
    List<Widget> tabBarViewList = List();
    for(var skillType in skillTypeList){
      tabBarViewList.add(
        Container(
          child: ListView.builder(
              itemCount: skillMap[skillType].length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  child:Text(skillMap[skillType][index]['skill_label'])
                );
              }
          ),
        )
      );
    }
    return TabBarView(
      controller: tabController,
      children: tabBarViewList,
    );
  }


  loadSkills() async{
    skillTypeList = SkillController.getAllSkillType();
    for(int i=0;i<skillTypeList.length;i++){
      //全部http请求
      var data = await SkillController.getSameTypeSkills(i+1);
      skillMap[skillTypeList[i]] = data;
    }
    print(22222);
    if(pageView == null){
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
          skillTypeSmallPage(skillMap[skillTypeList[8]]),
        ],
        onPageChanged: (index){
          setState(() {
            currentPage = index;
          });
        },
      );
    }


  }
  Widget skillTypeSmallPage(sameSkills){
//    print(sameSkills.toString());
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: sameSkills.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
                child:Text(sameSkills[index]['skill_label'])
            );
          }
      ),
    );
  }


  Widget buildSkillTypeContainer(String skillType){
    return Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        color: AppTheme.investigatorMinorColor,
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width
        ),
        child:  FlatButton(
            onPressed: (){
              //更新整个ListView
            },
            child: Text(skillType,style: TextStyle(fontSize: 18,color: Colors.white),)
        )
    );
  }


  Widget getSkillPanelList(String skillType){
  //获取每个技能类别的Expansiion的body
    List<Widget> skillPanels = List();
    for(var skill in skillMap[skillType]){
      skillPanels.add(
        Container(
            margin:EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(skill['skill_label']),
            ),
        )
      );
    }
    return Container(
      child: Column(
        children: skillPanels,
      ),
    );
  }


  List<ExpansionPanel> getSkillExpansionPanel(){
    //获取整个技能折叠板
    List<ExpansionPanel> expansionList = List();
    for(int i=0;i<skillTypeList.length;i++){
      expansionList.add(
          ExpansionPanel(
              headerBuilder: (context, isExpanded){
                return ListTile(
                  title: Text(skillTypeList[i]),
                );
              },
              body:getSkillPanelList(skillTypeList[i]),
              isExpanded: skillExpansionSwitch[i],
              canTapOnHeader: true,
          )
      );
    }
    return expansionList;
  }

  Widget getSkillExpansionPanelListWidget(){
    return ExpansionPanelList(
      children: getSkillExpansionPanel(),
        expansionCallback:(panelIndex, isExpanded){
          setState(() {
            skillExpansionSwitch[panelIndex] = !isExpanded;
          });
        },
        animationDuration : kThemeAnimationDuration,
    );
  }

  
  Wrap buildSkillTypeButton(){
    return Wrap(
      direction: Axis.horizontal,
      children: skillTypeList.map(
              (String skillType)=>Container(
                child: FlatButton(
                    onPressed: (){
                  for(int i=0;i<skillTypeList.length;i++){
                    if(skillTypeList[i] == skillType){
                        currentPage = i;
                        print(currentPage);
                        pageController.animateToPage(i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                    }
                  }
                }, child: Text(skillType)),
              )
      ).toList()
    );
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    Widget buildMainListWidget(){
      return Container(
        child: ListView(
          children: <Widget>[
            buildSkillTypeButton(),
            Container(
              margin: EdgeInsets.fromLTRB(15,0,15,5),
              constraints: BoxConstraints(
                  maxHeight: 400,
                  maxWidth: 180
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
              future: loadSkills(),
            )
        )
    );


  }








}


