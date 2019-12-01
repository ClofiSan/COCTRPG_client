import 'package:flutter/material.dart';
import 'random_property_page.dart';
import 'package:coc_trpg/controller/investigator_controller.dart';
import 'package:coc_trpg/model/Property.dart';
class CreateGroupPage extends StatefulWidget{
  CreateGroupPage({Key key}): super(key: key);

  @override
  _CreateGroupPage createState() => _CreateGroupPage();

}


class _CreateGroupPage extends State<CreateGroupPage>{

  PageView _pageView;
  int _currentPage = 0;
  PageController _pageController;

  @override
  void initState(){
    super.initState();
    List<Property> propertyList = InvestigatorController.loadRandomPropertyList();
    _pageController = PageController();
    _pageView = PageView(
      controller: _pageController,
      children: <Widget>[
        RandomPropertyPage(propertyList: InvestigatorController.loadRandomPropertyList(),),
        RandomPropertyPage(propertyList: InvestigatorController.loadRandomPropertyList(),),
        RandomPropertyPage(propertyList: InvestigatorController.loadRandomPropertyList(),),
      ],
      onPageChanged: (index){
        setState(() {
          _currentPage = index;
        });
      }
    );
  }

  Widget buildGroupLabel(String text,int page){
    return  Container(

      decoration:_currentPage == page ? BoxDecoration(

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
            child: Text(text,style: TextStyle(fontSize: 18),)
        ),
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("选择出目",style: TextStyle(fontSize: 45),),
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
                      child:   Text(
                        "选择一组中意的属性数据作为新任调查员的基础数值",
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30,top: 15),
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints(
                  maxWidth:300,
                ),
                child: Row(
                  children: <Widget>[
                    buildGroupLabel("第一组", 0),
                    buildGroupLabel("第二组", 1),
                    buildGroupLabel("第三组", 2),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                margin: EdgeInsets.fromLTRB(30,0,30,5),
                constraints: BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 300
                ),
                child: _pageView,
                decoration: BoxDecoration(
                  color: Color(0x22000000),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.bottomCenter,
                constraints: BoxConstraints(
                    maxWidth: 300
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        color: Color(0xffbdbdbd),
                        child: Text("重骰",style: TextStyle(color: Colors.white,fontSize: 18),),
                        onPressed: (){

                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child:RaisedButton(
                        color: Color(0xff20BAC1),
                        child: Text("继续",style: TextStyle(color: Colors.white,fontSize: 18),),
                        onPressed: (){

                        },
                      )
                    ),



                  ],
                ),
              )
            ],
        ),
      ),
    );
  }
  
}


