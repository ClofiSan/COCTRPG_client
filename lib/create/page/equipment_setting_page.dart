import 'package:flutter/material.dart';
import 'package:coc_trpg/create/widget/create_title_widget.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Weapon.dart';
import 'package:coc_trpg/store/CreateInvestigatorStore.dart';
import 'package:coc_trpg/controller/WeaponController.dart';
import 'package:provider/provider.dart';
import 'package:coc_trpg/create/widget/create_item_title_widget.dart';
import 'package:coc_trpg/create/widget/content_container.dart';
import 'package:coc_trpg/AppThemeData.dart';
class EquipmentSettingPage extends StatefulWidget{
  EquipmentSettingPage({Key key}): super(key: key);

  @override
  _EquipmentSettingPage createState() => _EquipmentSettingPage();

}


class _EquipmentSettingPage extends State<EquipmentSettingPage>{

  Future _futureBuilderFuture;
  WeaponController _weaponController;
  Map<String,List<Weapon>> _weaponMap;
  List<String> _weaponTypeList;
  Investigator _investigator;
  List<Weapon> _investigatorWeaponList;
  List<String> _equipmentSettingList;
  String _newEquipment;
  Weapon _bottomSheetWeapon;
  List<Weapon> chosenWeaponList = List();

  Future loadEquipmentAndWeapon() async {
    _investigatorWeaponList = List();
    _equipmentSettingList = List();
    _weaponController = WeaponController();
    await _weaponController.loadWeapons();
    _weaponMap = Map();
    _weaponMap = _weaponController.getAllWeapon();
    _weaponTypeList = List();
    _weaponTypeList = _weaponController.getWeaponType();
    _bottomSheetWeapon = _weaponMap["常规武器"][0];
    chosenWeaponList = loadChosenWeaponList();
    _investigator = Provider.of<CreateInvestigatorStore>(context,listen: false).investigator;

  }


  loadChosenWeaponList(){
    List<Weapon> list = List();
    for(int i=0;i<_weaponTypeList.length;i++){
      Weapon weapon = Weapon();
      weapon.name = _weaponTypeList[i];
      list.add(weapon);
      for(var item in _weaponMap[_weaponTypeList[i]]){
        list.add(item);
      }
    }
    return list;
  }

  @override
  void initState(){
    super.initState();
    _futureBuilderFuture = loadEquipmentAndWeapon();
  }

  showEquipmentInputDialog(String equipName){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: AppTheme.investigatorMinorColor,
            title: Text("输入装备信息",style: AppTheme.dialogTextStyle,),
            content: Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: equipName,
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                  )
                ),
                style: TextStyle(color: Colors.white,fontSize: 18),
                onChanged: (v){
                  _newEquipment = v;
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
                    _equipmentSettingList.add(_newEquipment);
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        }
    );
  }
  showEquipmentDeleteDialog(index){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: AppTheme.investigatorMinorColor,
            title: Text("删除装备",style: AppTheme.dialogTextStyle,),
            content: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "你确定删除 ${_equipmentSettingList[index]}?",
                style: AppTheme.dialogTextStyle,),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "确定",
                  style: AppTheme.dialogTextStyle,
                ),
                onPressed: (){
                  setState(() {
                    _equipmentSettingList.removeAt(index);
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        }
    );
  }

  Widget buildEquipmentAddButton(){
    return FlatButton(
      color: AppTheme.investigatorMainColor,
      child: Icon(Icons.add,color: Colors.white,),
      onPressed: (){
       showEquipmentInputDialog("");
      },
    );
  }

  Widget buildEquipmentList(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _equipmentSettingList.length + 1,
          itemBuilder: (BuildContext context,int index){
            if(index == _equipmentSettingList.length ){
              return buildEquipmentAddButton();
            }
            return ContentContainer(
                widget:FlatButton(
                    onLongPress: (){
                      showEquipmentDeleteDialog(index);
                    },
                    onPressed: (){
                      showEquipmentInputDialog(_equipmentSettingList[index]);
                    },
                    child: Text(
                      _equipmentSettingList[index],
                      style:AppTheme.createMinorColorBoxDescribeTextStyle ,
                    )
                )
            );
          }
      ),
    );
  }


  showWeaponBottomSheet(Weapon weapon){
    var _height = MediaQuery.of(context).size.height*0.8;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            height: _height,
            child: Column(
              children: <Widget>[
                FlatButton(
                  child:Text(_bottomSheetWeapon.name,style: TextStyle(fontSize: 20,color: Colors.black38),),
                  onPressed: (){
                    showWeaponChosenDialog();
                  }
                ),
                buildWeaponValueText("使用技能", _bottomSheetWeapon.relevantSkill),
                buildWeaponValueText("伤害", _bottomSheetWeapon.damage),
                buildWeaponValueText("贯穿", _bottomSheetWeapon.range),
                buildWeaponValueText("次数", _bottomSheetWeapon.frequency),
                buildWeaponValueText("装弹数", _bottomSheetWeapon.capasity),
                buildWeaponValueText("故障值", _bottomSheetWeapon.breakdown),
                buildWeaponValueText("年代", _bottomSheetWeapon.time),
                buildWeaponValueText("价格", _bottomSheetWeapon.price),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: buildWeaponConfirmButton(_bottomSheetWeapon),
                )
              ],
            ),
          );
        }
    );
  }


  showWeaponChosenDialog(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: AppTheme.investigatorMinorColor,
            title: Text("添加武器",style: AppTheme.dialogTextStyle,),
            content: Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.height*0.5
              ),
              child: ListView.builder(
                itemCount: chosenWeaponList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index){
                   return FlatButton(
                     onPressed: (){
                       setState(() {
                         _bottomSheetWeapon = chosenWeaponList[index];
                         Navigator.of(context).pop();
                       });

                     },
                       child: Text(
                         chosenWeaponList[index].name,
                         style:AppTheme.dialogTextStyle,
                       )
                   );
                  }
              ),
            ),
          );
        }
    );
  }

  Widget buildWeaponConfirmButton(Weapon weapon){
    return FlatButton(
      color: AppTheme.investigatorMainColor,
      child: Container(
        child: Text(
          "确定",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
      ),
      onPressed: (){
        setState(() {
          _investigatorWeaponList.add(weapon);
        });
      },
    );
  }

  Flex buildWeaponValueText(String attributeName,String value){
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 1,
          child:Text(
            attributeName,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16
            ),
          ) ,
        ),
        value != null?Expanded(
          flex: 2,
          child:Text(
            value,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16
            ),
          ) ,
        ):Container()

      ],
    );
  }


  Widget buildWeaponAddButton(){
    return FlatButton(
      color: AppTheme.investigatorMainColor,
      child: Icon(Icons.add,color: Colors.white,),
      onPressed: (){
        showWeaponBottomSheet(_bottomSheetWeapon);
      },
    );
  }
  popItem(Weapon weapon,bool isType){
    return PopupMenuItem<Weapon>(
      value: weapon,
      child: Text(
          weapon.name,
        style: isType?
        TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize: 18):
        TextStyle(color:Colors.white,fontSize: 16),
      ),
    );
  }
  PopupMenuButton<Weapon> buildWeaponPopMenu(){
    return PopupMenuButton<Weapon>(
      color: AppTheme.investigatorMinorColor,
      itemBuilder:(BuildContext context){
        List<PopupMenuItem<Weapon>> list = List();
        for(int i=0;i<_weaponTypeList.length;i++){
          Weapon weapon = Weapon();
          weapon.name = _weaponTypeList[i];
          list.add(popItem(weapon,true));
          for(var item in _weaponMap[_weaponTypeList[i]]){
            list.add(popItem(item,false));
          }
        }
        return list;
      },
      onSelected: (Weapon w){
        setState(() {
          _bottomSheetWeapon = w;
        });
      },
    );
  }

  Widget buildWeaponList(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _investigatorWeaponList.length + 1,
          itemBuilder: (BuildContext context,int index){
            if(index == _investigatorWeaponList.length ){
              return buildWeaponAddButton();
            }
            return ContentContainer(
                widget:FlatButton(
                    onLongPress: (){

                    },
                    onPressed: (){
                      _bottomSheetWeapon = _investigatorWeaponList[index];
                      showWeaponBottomSheet(_bottomSheetWeapon);
                    },
                    child: Text(
                      _investigatorWeaponList[index].name,
                      style:AppTheme.createMinorColorBoxDescribeTextStyle ,
                    )
                )
            );
          }
      ),
    );
  }




  Widget buildMainListWidget(){
    return Container(
      child: ListView(
          children: <Widget>[
            CreateTitleWidget(
              title: "装备与武器",
              description: "好的装备是成功实现骚操作的条件之一",
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                      color: Colors.red,
              alignment: Alignment.center,
              constraints: BoxConstraints(
                  maxWidth: 100
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CreateItemTitleWidget(title: "装备",),
                  buildEquipmentList(),
                  CreateItemTitleWidget(title: "武器",),
                  buildWeaponList(),
                ],
              ),
            ),
          ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot){
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          print('none');
          return Text('ConnnectionState.none');
        case ConnectionState.active:
          print('active');
          return Text('ConnectionState.active');
        case ConnectionState.waiting:
          print('waiting');
          return Center(
            child: CircularProgressIndicator(),
          );
        case ConnectionState.done:
          print('done');
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return buildMainListWidget();
        default:
          return null;
      }
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
            ),
            body:FutureBuilder(
              builder: _buildFuture,
              future: _futureBuilderFuture,
            )
        )
    );
  }

}




