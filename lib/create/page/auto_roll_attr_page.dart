import 'package:flutter/material.dart';
import 'package:coc_trpg/create/page/random_property_page.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
import 'package:coc_trpg/model/Property.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/create/page/interest_point_page.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:provider/provider.dart';
import 'package:coc_trpg/store/CreateInvestigatorStore.dart';
class AutoRollAttrPage extends StatefulWidget{
  AutoRollAttrPage({Key key}): super(key: key);

  @override
  _AutoRollAttrPage createState() => _AutoRollAttrPage();

}


class _AutoRollAttrPage extends State<AutoRollAttrPage>{
  

  List<Property> property = List();
  int mov;
  String damagePlus;
  int phyi;
  int HP;
  int MP;
  int SAN;

  Widget propertyPage;
  Widget otherPropertyView;
  Widget propertySumView;



  void resetPropertyGroup(){
    property = InvestigatorController.loadRandomPropertyList();
    mov = InvestigatorController.getInvestigatorMov(property);
    phyi = InvestigatorController.getInvestigatorPhysique(property);
    HP = InvestigatorController.getInvestigatorHP(property);
    MP = InvestigatorController.getInvestigatorMP(property);
    SAN = InvestigatorController.getInvestigatorSan(property);
    damagePlus = InvestigatorController.physiqueDamageMap[phyi];
  }

  @override
  void initState(){
    resetPropertyGroup();
    propertyPage = RandomPropertyPage(propertyList: property);
    otherPropertyView = buildOtherProperty();
    super.initState();
  }

  Widget buildOtherProperty(){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              padding: EdgeInsets.all(10),
              color: AppTheme.investigatorMinorColor,
              child: Column(
                children: <Widget>[
                  BuildPropertyElement('体力', HP.toString()),
                  BuildPropertyElement('魔力', MP.toString()),
                  BuildPropertyElement('理智', SAN.toString()),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              color: AppTheme.investigatorMinorColor,
              child: Column(
                children: <Widget>[
                  BuildPropertyElement('体格', phyi.toString()),
                  BuildPropertyElement('移动', mov.toString()),
                  BuildPropertyElement('伤害加成', damagePlus),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BuildPropertyElement(String name,String value){
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Text(name,style: AppTheme.createMinorColorBoxDescribeTextStyle,),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(value,style: AppTheme.createMinorColorBoxDescribeTextStyle,),
            ),
          )
        ],
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
              buildOtherProperty(),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                margin: EdgeInsets.fromLTRB(30,10,30,5),
                constraints: BoxConstraints(
                    maxHeight: 350,
                    maxWidth: 300
                ),
                child:propertyPage,
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
                          resetPropertyGroup();
                          setState(() {
                            propertyPage = RandomPropertyPage(propertyList: property);
                            otherPropertyView = buildOtherProperty();
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child:RaisedButton(
                        color: Color(0xff20BAC1),
                        child: Text("选择",style: TextStyle(color: Colors.white,fontSize: 18),),
                        onPressed: (){

                          Investigator investigator = Investigator();
                          investigator.properties = property;
                          investigator.HP = InvestigatorController.getInvestigatorHP(property);
                          investigator.San = InvestigatorController.getInvestigatorSan(property);
                          investigator.MP = InvestigatorController.getInvestigatorMP(property);
                          investigator.damagePlus = damagePlus;
                          investigator.Phy = phyi;
                          Provider.of<CreateInvestigatorStore>(context,listen: false).investigator = investigator;
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>InterestPointPage(investigator: investigator,)));
                        },
                      )
                    )


                  ],
                ),
              )
            ],
        ),
      ),
    );
  }
  
}


