import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'property_page.dart';
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

  @override
  void initState(){
    super.initState();
    loadInvestigators();
    _pageController = new PageController();
    _pageView = new PageView(
      controller: _pageController,
      children: <Widget>[
//        PropertyPage(),
//        PropertyPage()
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
    investigator.name = "莱因哈特";
    investigator.imageUrl = "assets/head.jpg";
    investigatorList.add(investigator);
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
          title: Text("name"),
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
        body:Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Image.asset(HPImage),
                  Image.asset(investigatorList[0].imageUrl),
                  Image.asset(SANImage),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration:_currentPage == 0 ? BoxDecoration(

                      ):null,
                      child: FlatButton(
                          onPressed: (){},
                          child: Text("属性")
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration:_currentPage == 1 ? BoxDecoration(

                      ):null,
                      child: FlatButton(
                          onPressed: (){},
                          child: Text("技能")
                      ),
                    ),
                  ),

                ],
              ),
            ),
            _pageView,

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


