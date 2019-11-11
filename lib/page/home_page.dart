import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Property.dart';
import 'property_page.dart';
import 'package:coc_trpg/model/Skill.dart';
class HomePage extends StatefulWidget{
  HomePage({Key key}): super(key: key);

  @override
  _HomePage createState() => _HomePage();

}


class _HomePage extends State<HomePage>{

  List<Investigator> investigatorList = List();
  String HPImage = "asset/head.jpg";
  String SANImage = "asset/head.jpg";
  PageController _pageController;
  PageView _pageView;
  int _currentPage = 0;

  List<Widget> loadSkillWidgetList(List<Skill> skillList){
    List<Widget> skillWidgetList = new List();
    for (var skill in skillList){
      skillWidgetList.add(
        new Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.horizontal,

          ),
        )
      );
    }

  }

  List<Widget> loadPropertyWidgetList(List<Property> propertyList){
    List<Widget> propertyWidgetList = new List();
  }


  @override
  void initState(){
    super.initState();
    loadInvestigators();
    _pageController = new PageController();
    _pageView = new PageView(
      controller: _pageController,
      children: <Widget>[
        PropertyPage(list:loadSkillWidgetList(investigatorList[0].skills),),
        PropertyPage(list:loadPropertyWidgetList(investigatorList[0].properties),),
      ],
      onPageChanged: (index){
        setState(() {
          _currentPage = index;
        });
      },
    );

  }


  void loadInvestigators(){
    Investigator investigator = new Investigator();
    investigator.name = "空调承太郎";
    investigator.imageUrl = "assets/head.jpg";
    investigator.properties = loadTestProperty();
    investigator.skills = loadTestSkillList();
    investigatorList.add(investigator);
  }

  List<Property> loadTestProperty(){
    List<Property> propertyList = new List();
    for(int i=0;i<8;i++){
      propertyList.add(new Property("幸运", "LUC", 60));
    }
    return propertyList;
  }
  List<Skill> loadTestSkillList(){
    List<Skill> skillList = new List();
    for(int i=0;i<8;i++){
      skillList.add(new Skill("侦查", "Search", 60));
    }
    return skillList;
  }



  Widget buildBottomAppbar(){



    return BottomAppBar(
      color: Color(0x44000000),
      shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
      child: Row(
        children: [
          IconButton(
            icon: ImageIcon(AssetImage("assets/icon/function_icon/encyclopedia.png"),size: 40,),
          ),
          IconButton(icon: ImageIcon(AssetImage("assets/icon/function_icon/coc_rules.png"),size: 40,)),
          SizedBox(), //中间位置空出
          SizedBox(), //中间位置空出
          SizedBox(), //中间位置空出
          IconButton(icon: ImageIcon(AssetImage("assets/icon/function_icon/record.png"),size: 40,)),
          IconButton(icon: ImageIcon(AssetImage("assets/icon/function_icon/individual.png"),size: 40,)),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
      ),
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
          title: Text(investigatorList[0].name),
          backgroundColor: Color(0x22000000),
          elevation: 0,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 20),
              child:  IconButton(
                  icon:ImageIcon(AssetImage("assets/icon/function_icon/search.png"),) ,
                  onPressed:(){

                  }
              )
              ,
            ),
          ],
        ),
        bottomNavigationBar: buildBottomAppbar(),
        body:ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(SANImage,width: 40,height: 40,),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      image:new DecorationImage(
                          image: new AssetImage(investigatorList[0].imageUrl),
                          fit: BoxFit.cover
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Image.asset(SANImage,width: 40,height: 40,),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                color: Color(0xff20BAC1),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 100,
                  ),
                  child:Row(
                    children: <Widget>[
                      ImageIcon(AssetImage("assets/icon/function_icon/notebook.png"),),
                      Text("调查笔记",style: TextStyle(fontSize: 18),),

                    ],
                  )
                ),
                onPressed: (){
                  
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                maxWidth: 150,
              ),
              child: Row(
                children: <Widget>[
                Container(

                      decoration:_currentPage == 0 ? BoxDecoration(

                        color: Colors.white,
                      ):BoxDecoration(
                        color:  Color(0x22000000),),
                      child: Center(
                        child: FlatButton(
                            onPressed: (){
                              _pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                            },
                            child: Text("属性",style: TextStyle(fontSize: 18),)
                        ),
                      ),
                    ),

                 Container(
                      decoration:_currentPage == 1 ? BoxDecoration(

                        color: Colors.white,
                      ):BoxDecoration(
                        color:  Color(0x22000000),
                      ),
                      child: Center(
                        child: FlatButton(
                            onPressed: (){
                              _pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                            },
                            child: Text("技能",style: TextStyle(fontSize: 18),)
                        ),
                      ),
                    ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15,0,15,5),
              constraints: BoxConstraints(
                maxHeight: 400,
                maxWidth: 180
              ),
              child: _pageView,
              decoration: BoxDecoration(
                  color: Color(0x22000000),
              ),
            ),

          ],

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff20BAC1),
          child: Image.asset(
            "assets/icon/function_icon/home.png",width: 30,height: 30,),
          onPressed: (){

          },
        )
      ),
    );
  }

}


