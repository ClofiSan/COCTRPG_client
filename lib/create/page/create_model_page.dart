import 'package:flutter/material.dart';
import 'package:coc_trpg/create/page/auto_roll_attr_page.dart';
class CreateModelPage extends StatefulWidget{
  CreateModelPage({Key key}): super(key: key);

  @override
  _CreateModelPage createState() => _CreateModelPage();

}


class _CreateModelPage extends State<CreateModelPage>{
  
  Widget buildModelButton(Color backgroundColor,String en,String model,String description){
    return Container(
      margin: EdgeInsets.only(right: 10),
      constraints: BoxConstraints(
          maxWidth: 180
      ),
      child:RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              child:Text(en,style: TextStyle(color: Colors.white),),
              margin: EdgeInsets.only(top: 50),
            ),
            Container(
              child: Text(model,style: TextStyle(color: Colors.white,fontSize: 60)),
            ),
            Container(
                child:Text(description,style: TextStyle(color: Colors.white,fontSize: 18)),
                padding: EdgeInsets.all(20),
//                margin: EdgeInsets.only(left: 2)
            ),
          ],
        ),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) =>AutoRollAttrPage()));
        },
      )
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
          appBar:AppBar(
            title: Container(
              alignment: Alignment.center,
              child: Text("新建调查员",style: TextStyle(color: Colors.white,),
            ),
          ),
            backgroundColor: Color(0x22000000),
            elevation: 0,
        ),
          body: Container(
            margin: EdgeInsets.only(top: 150),
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildModelButton(Colors.black54, "Automatic", "自动", "适合初来乍到的新调查员建立档案"),
                  buildModelButton(Colors.black, "Manual", "手动", "适合为经验丰富的老调查员建立档案"),
                ],
              ),
            ),
          )
    );
  }
  
}


