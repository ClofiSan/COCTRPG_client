import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Property.dart';

class RandomPropertyPage extends StatefulWidget{
  RandomPropertyPage({Key key, this.propertyList}): super(key: key);
  final List<Property> propertyList;
  @override
  _RandomPropertyPage createState() => _RandomPropertyPage();

}


class _RandomPropertyPage extends State<RandomPropertyPage>{


  @override
  void initState() {
    // TODO: implement initState
    buildPropertyList(widget.propertyList);
    super.initState();

  }

  Widget _buildPropertyFlexWidget(String label,String value){
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(label),
        ),
        Expanded(
          flex: 1,
          child: Text(value),
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
          Widget flex2 = _buildPropertyFlexWidget("","");
        }else{
          Widget flex2 = _buildPropertyFlexWidget(propertyList[++i].label,propertyList[i].value.toString());
        }
        _propertyWidgetList.add(
            new Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 150
                      ),
                      child: flex1
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 150
                      ),
                      child: flex2,
                    )
                ),
              ],
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
    return Container(
      child: Column(
        children: buildPropertyList(widget.propertyList)
      ),
    );
  }

}


