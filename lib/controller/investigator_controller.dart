import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Property.dart';
import 'dart:math' as Math;

class InvestigatorController{

  static final Map<String,String> propertyNameLabelMap = {
    "STR":"力量",
    "CON":"体质",
    "DEX":"敏捷",
    "SIZ":"体型",
    "APP":"外貌",
    "INT":"智力",
    "POW":"意志",
    "EDU":"教育"
  };
  static final Map<String,String> propertyNameRuleMap = {
    "STR":"3D6",
    "CON":"3D6",
    "DEX":"3D6",
    "SIZ":"2D6",
    "APP":"3D6",
    "INT":"2D6",
    "POW":"3D6",
    "EDU":"2D6"
  };


  //添加
  static List<Property> loadRandomPropertyList(){
    //力量，智力，敏捷，意志，体质，教育，外貌，体型
    List<Property> propertyList = List();
    for(var name in propertyNameLabelMap.keys){
      propertyList.add(_rollProperty(name,propertyNameLabelMap[name], propertyNameRuleMap[name]));
    }
    print(propertyList.toString());
    return propertyList;
  }

  static Property _rollProperty(String name,String label,String rule){
    int round = 0;
    int sumRollPoint = 0;
    if(rule == "3D6"){
      round = 3;
    }else{
      round = 2;
      sumRollPoint += 6;
    }
    for(int i=0;i < round;i++){
      int rollPoint = Math.Random().nextInt(6);
      sumRollPoint += rollPoint;
    }

    Property property = Property();
    property.name = name;
    property.label = label;
    property.value = sumRollPoint * 5;
    return property;
  }
}