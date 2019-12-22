import 'package:flutter/material.dart';
import 'package:coc_trpg/model/Occupation.dart';
import 'create_occupation_skill_page.dart';
import 'package:coc_trpg/AppThemeData.dart';
import 'package:coc_trpg/AppThemeData.dart';
class OccupationListPage extends StatefulWidget{
  OccupationListPage({Key key, this.occupationList, this.currentOccupationIndex}): super(key: key);
  final List<Occupation> occupationList;
  final int currentOccupationIndex;
  @override
  _OccupationListPage createState() => _OccupationListPage();

}


class _OccupationListPage extends State<OccupationListPage>{

  Occupation _currentOccupation = Occupation();
  List<Occupation> _occupationList = List();
  int _currentOccupationIndex = 0;
  Occupation _emergencyOccupation = Occupation();

  @override
  void initState() {
    // TODO: implement initState
    _occupationList = widget.occupationList;
    _currentOccupationIndex = widget.currentOccupationIndex;
    _currentOccupation = _occupationList[_currentOccupationIndex];
    super.initState();
  }

  TextStyle _descriptionTextStyle = TextStyle(
      fontSize: 18,
      color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    showConfirmDialog(BuildContext context){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              backgroundColor: AppTheme.investigatorMinorColor,
              title: Text("确认选择",style: _descriptionTextStyle,),
              content:
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.1,
                child:Container(
                  child: Text("选择${_occupationList[_currentOccupationIndex].name}为职业？",style: AppTheme.createMinorColorBoxDescribeTextStyle,),
                )
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    setState(() {
                      //状态管理，进行相关页面的状态更细
                      _currentOccupation = _occupationList[_currentOccupationIndex];
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new CreateOccupationSkillPage()));
                    });
                  },
                  child: Text("选择",style: _descriptionTextStyle,),
                ),
                FlatButton(
                  onPressed: (){
                    setState(() {
                      //状态管理，进行相关页面的状态更细
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("取消",style: _descriptionTextStyle,),
                ),
              ],
            );
          }
      );
    }


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
          title: Text("职业列表",style: AppTheme.createMinorColorBoxDescribeTextStyle,),
          actions: <Widget>[
            FlatButton(
              child: Text("选择",style: _descriptionTextStyle,),
              onPressed: (){
                showConfirmDialog(context);
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount:_occupationList.length ,
            itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.only(bottom: 5),
                color: _currentOccupationIndex == index ? AppTheme.investigatorMainColor:null,
                child: FlatButton(
                    onPressed: (){
                      _currentOccupationIndex = index;
                      setState(() {

                      });
                    },
                    child: Text(_occupationList[index].name,
                      style: _descriptionTextStyle,)
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}


