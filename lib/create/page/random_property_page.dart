import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Property.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
import 'package:coc_trpg/AppThemeData.dart';
class RandomPropertyPage extends StatefulWidget{
  RandomPropertyPage({Key key, this.propertyList}): super(key: key);
  final List<Property> propertyList;
  @override
  _RandomPropertyPage createState() => _RandomPropertyPage();

}


class _RandomPropertyPage extends State<RandomPropertyPage>{


  int sum = 0;

  Map<String,TextEditingController> propertyControllerMap ;
  @override
  void initState() {
    // TODO: implement initState

    buildPropertyList(widget.propertyList);
    super.initState();

  }

  InputDecoration buildSkillPointInputDecoration(String hintText){
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16,color: Colors.grey),
        border: InputBorder.none,
        fillColor: AppTheme.investigatorMinorColor,
        filled: true,
        errorStyle: TextStyle(color: Colors.red[600]),
    );
  }

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
          child: Container(
            width: MediaQuery.of(context).size.width*0.5,
            height: 30,
            constraints: BoxConstraints(
              maxWidth: 30
            ),
            child: FlatButton(
              color: AppTheme.investigatorMinorColor,
              child: Text(
                value,
                style: TextStyle(fontSize: 18,color: Colors.white,),
              ),
              onPressed: (){
                propertyControllerMap[label].text = value;
                showDialog(
                    context: context,
                  builder: (context){
                      return AlertDialog(
                        backgroundColor: AppTheme.investigatorMinorColor,
                        title: Text("输入$label数值",style: AppTheme.dialogTextStyle,),
                        content: Container(
                          child: TextField(
                            autofocus: true,
                            controller: propertyControllerMap[label],
                            style: TextStyle(fontSize: 18,color: Colors.white,),
                            onChanged: (v){
                              for(var item in widget.propertyList){
                                if(item.label == label){
                                  item.value = int.parse(v);
                                  break;
                                }
                              }
                            },
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "确定",
                              style: AppTheme.dialogTextStyle,
                            ),
                            onPressed: (){
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                          )
                        ],
                      );
                  }
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildSumAttriWigdet(List<Property> propertyList){
    sum = InvestigatorController.getInvestigatorPropertySum(widget.propertyList);
    return Container(
      margin: EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      child: Text(
        "总点数(除幸运) ${sum}",
        style: TextStyle(color: Colors.black,fontSize: 20),
      ),
    );
  }

  List<Widget> buildPropertyList(List<Property> propertyList){
    List<Widget> _propertyWidgetList = List();
    Map<String,TextEditingController> map = Map();
    for(var item in widget.propertyList){
      map[item.label] = new TextEditingController();
      map[item.label].text = item.value.toString();
    }
    propertyControllerMap = map;
    try{
      _propertyWidgetList.add(buildSumAttriWigdet(widget.propertyList));
      for(int i=0;i<propertyList.length;i++){
        Widget flex1 = _buildPropertyFlexWidget(propertyList[i].label,propertyList[i].value.toString());
        Widget flex2;
        if( i + 1 >= propertyList.length){
           flex2 = Container();
        }else{
           flex2 = _buildPropertyFlexWidget(propertyList[++i].label,propertyList[i].value.toString());
        }
        _propertyWidgetList.add(
          new Container(
            margin: EdgeInsets.only(top: 20,right: 10),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                    flex: 3,
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
                    )
                ),
                Expanded(
                    flex: 3,
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: buildPropertyList(widget.propertyList),
    );
  }

}


