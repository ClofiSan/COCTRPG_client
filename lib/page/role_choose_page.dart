import 'package:flutter/material.dart';
import 'package:coc_trpg/utils/ClipTriangleUtil.dart';
import 'home_page.dart';
class RoleChoosePage extends StatefulWidget{
  RoleChoosePage({Key key}): super(key: key);

  @override
  _RoleChoosePage createState() => _RoleChoosePage();

}


class _RoleChoosePage extends State<RoleChoosePage>{

  final Map<String,List<Color>> roleThemeColor = {
    "PL":[Color(0xDd20BAC1), Colors.grey],
    "KP":[Colors.grey,Colors.white]
  } ;

  List<Color> _gradientColors ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    _gradientColors = roleThemeColor["PL"];

    Widget buildChosenButton(bool isKeeper){
      return Container(
          height: height / 1.1,
          width: width / 1.1,
          padding: EdgeInsets.fromLTRB(5, 5, 5, 50),
          alignment: isKeeper ? Alignment.bottomRight : Alignment.topLeft,
          child:ClipPath(
            clipper: ClipTriangle(isKeeper: isKeeper),
            child: ButtonTheme(
              minWidth: width / 1.2,
              height: height / 1.2,
              child: RaisedButton(
                color: Color(0x0020BAC1),
                child: Container(
                  alignment: isKeeper ? Alignment.bottomRight : Alignment.topLeft,
                  child: Image.asset(
                    isKeeper ? "assets/icon/function_icon/keeperButton.png"
                        : "assets/icon/function_icon/plButton.png" ,
                    width: width / 2.2,
                    height: height / 2.2,
                  ),
                ),
                onPressed: (){
                  if(isKeeper){
                    setState(() {
                      _gradientColors = roleThemeColor["KP"];

                    });
                  }else{
                    setState(() {
                      _gradientColors = roleThemeColor["PL"];
                    });
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) =>HomePage()));

                },
              ),
            ),
          )
      );
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              buildChosenButton(true),
              buildChosenButton(false)
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
        ),
      );
  }
  
}


