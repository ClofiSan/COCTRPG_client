import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Property.dart';
import 'dart:math' as Math;

class InvestigatorController{

  static List<String> propertyList = [
    "STR",
    "CON",
    "DEX",
    "SIZ",
    "APP",
    "INT",
    "POW",
    "EDU",
    "LUC"
  ];

  static final Map<String,String> initPropertyNameLabelMap = {
    "STR":"力量",
    "CON":"体质",
    "DEX":"敏捷",
    "SIZ":"体型",
    "APP":"外貌",
    "INT":"智力",
    "POW":"意志",
    "EDU":"教育",
    "LUC":"幸运"
  };
  static final Map<String,String> initPropertyNameRuleMap = {
    "STR":"3D6",
    "CON":"3D6",
    "DEX":"3D6",
    "SIZ":"2D6",
    "APP":"3D6",
    "INT":"2D6",
    "POW":"3D6",
    "EDU":"2D6",
    "LUC":"3D6"
  };


  //添加
  static List<Property> loadRandomPropertyList(){
    //力量，智力，敏捷，意志，体质，教育，外貌，体型
    List<Property> propertyList = List();
    for(var name in initPropertyNameLabelMap.keys){
      propertyList.add(_rollProperty(name,initPropertyNameLabelMap[name], initPropertyNameRuleMap[name]));
    }
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

  static List<Property> rollDetailProperty(List<Property> propertyList){
    List<Property> _newPropertyList = propertyList;

    return _newPropertyList;
  }
  static int getInvestigatorHP(List<Property> propertyList){
    int SIZ = 0;
    int CON = 0;
    propertyList.forEach((e) =>{
      if(e.name == "SIZ"){
        SIZ = e.value
      }else if (e.name == "CON"){
        CON = e.value
      }
    });
    int hp = (SIZ+CON)~/10;
    if(hp == 0){
      print("体型体质为空");
      return null;
    }
    return hp;
  }


  static int getInvestigatorMP(List<Property> propertyList){
    int POW = 0;
    propertyList.forEach((e) =>{
      if(e.name == "POW"){
        POW = e.value
      }
    });
    int MP = POW~/5;
    if(MP == 0){
      print("意志为空");
      return null;
    }
    return MP;
  }

  static int getInvestigatorSan(List<Property> propertyList){
    int POW = 0;
    propertyList.forEach((e) =>{
      if(e.name == "POW"){
        POW = e.value
      }
    });
    int San = POW;
    if(San == 0){
      print("意志为空");
      return null;
    }
    return San;
  }
  
  static int getInvestigatorInteresPoint(Investigator investigator){
    int point = 0;
    investigator.properties.forEach((e)=>{
      if(e.name == 'INT'){
        point = e.value
      }
    });
    return point;
  }

  String _catchString(String catchChar,String str){
    return str.startsWith(catchChar) ? str.substring(str.length) : null;
  }

  String _catchProperty(String str){
    for (var item in propertyList){

    }
  }

  int getSkillPointByRules(String rules,Investigator investigator){
    if(rules.trim() == '') return null;
    String rest = rules;
    int sumPoint = 0;

    while(rest != ''){
      String orRest = _catchString("or", rules);
      if(orRest != null){

      }
    }
  }




}