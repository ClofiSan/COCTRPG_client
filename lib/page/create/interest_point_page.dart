import 'package:flutter/material.dart';
import 'package:coc_trpg/controller/investigator_controller.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Property.dart';
import 'create_base_info_page.dart';

class InterestPointPage extends StatefulWidget{
  InterestPointPage({Key key, this.investigator}): super(key: key);

  final Investigator investigator;
  @override
  _InterestPointPage createState() => _InterestPointPage();

}


class _InterestPointPage extends State<InterestPointPage>{

  List<Widget> propertyWidgetList = List();

  Widget _buildPropertyFlexWidget(String label,String value){
    return Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(label,style:TextStyle(fontSize: 18,color: Colors.white,)),
        ),
        Expanded(
          flex: 1,
          child: Text(value,style:TextStyle(fontSize: 18,color: Colors.white,)),
        )
      ],
    );
  }

  List<Widget> buildPropertyList(List<Property> propertyList){
    List<Widget> _propertyWidgetList = List();
    try{
      for(int i=0;i<propertyList.length;i++){
        Widget flex1 = _buildPropertyFlexWidget(propertyList[i].label,propertyList[i].value.toString());
        Widget flex2;
        if( i + 1 >= propertyList.length){
          flex2 = _buildPropertyFlexWidget("","");
        }else{
          flex2 = _buildPropertyFlexWidget(propertyList[++i].label,propertyList[i].value.toString());
        }
        _propertyWidgetList.add(
            new Container(
              margin: EdgeInsets.only(top: 20),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                              maxWidth: 150
                          ),
                          child: flex1
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxWidth: 150
                        ),
                        child: flex2,
                      )
                  ),
                ],
              ),
            )

        );
      }
    }catch (e){
      //list 溢出
      print(e);
    }


    return _propertyWidgetList;
  }


  @override
  void initState() {
    // TODO: implement initState
    propertyWidgetList = buildPropertyList(widget.investigator.properties);
    super.initState();

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
                  Text("出目详情",style: TextStyle(fontSize: 45),),
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
                      "这组属性的详细数据",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              constraints: BoxConstraints(
                maxWidth:300,
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset("assets/SAN.png",height: 60,width: 60,),
                          Text(widget.investigator.San.toString())
                        ],
                      ),
                      constraints: BoxConstraints(
                          maxWidth: 80,
                          maxHeight: 90
                      ),
                    ) ,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset("assets/HP.png",height: 60,width: 60,),
                          Text(widget.investigator.HP.toString())
                        ],
                      ),
                      constraints: BoxConstraints(
                          maxWidth: 80,
                          maxHeight: 90
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Image.asset("assets/Mp.jpg",height: 60,width: 60,),
                          Text(widget.investigator.MP.toString())
                        ],
                      ),
                      constraints: BoxConstraints(
                          maxWidth: 80,
                          maxHeight: 90
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                maxWidth: 300
              ) ,
              child: Row(
                children: <Widget>[

                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 30,right: 30),
              margin: EdgeInsets.fromLTRB(30,0,30,5),
              constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 300
              ),
              child: Column(
                children: propertyWidgetList
              ),
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
                      child: Text("返回",style: TextStyle(color: Colors.white,fontSize: 18),),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child:RaisedButton(
                        color: Color(0xff20BAC1),
                        child: Text("继续",style: TextStyle(color: Colors.white,fontSize: 18),),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>BaseInfoPage(investigator: widget.investigator,)));
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


