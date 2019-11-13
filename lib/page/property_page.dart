import 'package:flutter/material.dart';
import 'package:coc_trpg/utils/roll_util.dart';
import 'package:coc_trpg/model/Attribute.dart';

class PropertyPage extends StatefulWidget{
  PropertyPage({Key key, this.attributeData}): super(key: key);
  final List<Attribute> attributeData;
  @override
  _PropertyPage createState() => _PropertyPage();

}


class _PropertyPage extends State<PropertyPage>{

  Map<int,String> rollResult = Map();
  ScrollController _scrollController = ScrollController();
  int currentAttributeValue = -1;
  int currentAttributeIndex = -1;
  
  @override
  void initState(){
    super.initState();
    _scrollController.addListener((){
      print(_scrollController.offset);
    });
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(50, 20, 50, 50),
      alignment: Alignment.center,
      child:Column(
        children: <Widget>[
          Container(
           constraints: BoxConstraints(
           maxHeight: 150
          ),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.attributeData.length,
              itemBuilder:(context,index){
                return  Container(
                  decoration: currentAttributeIndex == index ? 
                  BoxDecoration(
                    color: Color(0x33000000)
                  ):null,
                    alignment: Alignment.center,
                    child:FlatButton(
                        onPressed: (){
                          setState(() {
                            currentAttributeIndex = index;
                            currentAttributeValue = widget.attributeData[index].value;
                          });
                          print(currentAttributeValue);
                        },
                        child:Text(
                          "${widget.attributeData[index].label} ${widget.attributeData[index].value}",
                          style: TextStyle(fontSize: 22),
                        )
                    ),
                );
              }
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
            padding: EdgeInsets.all(10),
            child: Text("D100 DICE = ${rollResult.toString()}",style:TextStyle(fontSize: 22),),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25.0))
            ),
            constraints: BoxConstraints(
              minWidth: 210
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              color: Color(0xff20BAC1),
              child: Text("ROLL",style: TextStyle(color: Colors.white,fontSize: 18),),
              onPressed: (){
                setState(() {
                  print(currentAttributeValue);
                  if(currentAttributeValue == -1){

                  }else {
                    rollResult = RollUtil.Roll1D100(currentAttributeValue);
                  }
                });
              },
            ),
          ),

        ],

      ),
      constraints: BoxConstraints(
        maxWidth: 100,
        maxHeight: 100
      ),
      decoration: BoxDecoration(
      ),

    );
  }
  
}


