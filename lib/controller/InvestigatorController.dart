import 'package:coc_trpg/model/Investigator.dart';
import 'package:coc_trpg/model/Property.dart';
import 'dart:math' as Math;
import 'package:coc_trpg/model/Credit.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
class InvestigatorController{

  static test()async{
    var data = await rootBundle.loadString('assets/testData.JSON');
    var jsonData = json.decode(data);
    Investigator investigator  = Investigator.fromJson(jsonData);
    print(investigator.toString());
  }
  final Map<List<int>,dynamic> recentTimeCreditMap = {
    [0,0]:{
      "livingStandard":"身无分文",
      "cash":"\$0.5",
      "otherAssets":"没有",
      "consumptionLevel":"\$0.5",
    },
    [1,9]:{
      "livingStandard":"贫穷",
      "cash":"\$1-9 CR*1",
      "otherAssets":"\$10-90 CR*10",
      "consumptionLevel":"\$2",
    },
    [10,49]:{
      "livingStandard":"标准",
      "cash":"\$20-98 CR*2",
      "otherAssets":"\$500-2450 CR*50",
      "consumptionLevel":"\$10",
    },
    [50,89]:{
      "livingStandard":"小康",
      "cash":"\$250-445 CR*5",
      "otherAssets":"\$25000-44500\nCR*500",
      "consumptionLevel":"\$50",
    },
    [90,98]:{
      "livingStandard":"富裕",
      "cash":"\$1800-1960\nCR*20",
      "otherAssets":"\$180000-196000\nCR*2000",
      "consumptionLevel":"\$250",
    },
    [99,99]:{
      "livingStandard":"富豪",
      "cash":"\$50000",
      "otherAssets":"\$5M+",
      "consumptionLevel":"\$5000",
    }
  };
  final Map<List<int>,dynamic> modernTimeCreditMap = {
    [0,0]:{
      "livingStandard":"身无分文",
      "cash":"\$10",
      "otherAssets":"没有",
      "consumptionLevel":"\$10",
    },
    [1,9]:{
      "livingStandard":"贫穷",
      "cash":"\$20-180\nCR*20",
      "otherAssets":"\$20-1800\nCR*20",
      "consumptionLevel":"\$40",
    },
    [10,49]:{
      "livingStandard":"标准",
      "cash":"\$400-1960\nCR*40",
      "otherAssets":"\$10000-49000\nCR*1000",
      "consumptionLevel":"\$200",
    },
    [50,89]:{
      "livingStandard":"小康",
      "cash":"\$5000-8900 CR*100",
      "otherAssets":"\$50000-890000\nCR*1000",
      "consumptionLevel":"\$1000",
    },
    [90,98]:{
      "livingStandard":"富裕",
      "cash":"\$36000-39200\nCR*400",
      "otherAssets":"\$3.6M-3.92M\nCR*40000",
      "consumptionLevel":"\$5000",
    },
    [99,99]:{
      "livingStandard":"富豪",
      "cash":"\$1M",
      "otherAssets":"\$100M+",
      "consumptionLevel":"\$1000000",
    }
  };


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
  static final List<List<int>> physiqueMap = [
    [2,64],
    [65,84],
    [85,124],
    [125,164],
    [165,204]
  ];
  static final Map<int,int> iPhysiqueMap ={
    0:-2,
    1:-1,
    2:0,
    3:1,
    4:2
  };
  static final Map<int,String> physiqueDamageMap = {
    -2:'-2',
    -1:'-1',
    0:'0',
    1:'+1D4',
    2:'+1D6'
  };
  static final List<String> backgroundStoryList = [
    "个人描述",
    "思想/信念",
    "重要之人",
    "意义非凡之地",
    "宝贵之物",
    "特点",
    "伤口/疤痕",
    "恐惧症/狂躁症"
  ];

  static final List<String> timeDescription = [
    "1820 ~ 1920",
    "1920 ~ 1990",
    "1990 ~ 2010",
    "2010 ~ 至今",
    "文艺复兴时代",
    "维多利亚时代",
    "二战时期",
    "民国时期",
    "美苏冷战时期",
    "大萧条(禁酒令)时期",
    "嬉皮士时期",
    "蒸汽朋克",
    "架空历史",
    "近未来",
    "远未来",
    "其他"
  ];
  Credit getCredit(int point,{bool isModern = false}){
    var map = Map();
    Credit credit = Credit();
    if(isModern){
      map = modernTimeCreditMap;
    }else{
      map = recentTimeCreditMap;
    }
    for(var key in map.keys){
      if(point <= key[1]){
        credit.cash = map[key]["cash"];
        credit.consumptionLevel = map[key]["consumptionLevel"];
        credit.creditPoint = point;
        credit.livingStandard = map[key]["livingStandard"];
        credit.otherAssets = map[key]["otherAssets"];
        break;
      }
    }
    return credit;
  }

  static int getInvestigatorMov(List<Property> propertyList){
    int dex = 0;
    int str = 0;
    int siz = 0;
    for (var item in propertyList){
      if(item.name == 'STR'){
        str = item.value;
      }
      if(item.name == 'DEX'){
        dex = item.value;
      }
      if(item.name == 'SIZ'){
        siz = item.value;
      }
    }
    if(dex>siz&&str>siz){
      return 9;
    }else if (dex>siz || str>siz || (str==siz&&str==dex)){
      return 8;
    }else if (dex<siz&&str<siz){
      return 7;
    }
    return 7;
  }

  static int getInvestigatorPhysique(List<Property> propertyList){
    int sum = 0;
    for (var item in propertyList){
      if(item.name == 'STR' || item.name == 'SIZ'){
        sum += item.value;
      }
    }
    int physique = 2;
    for(int i=0;i<physiqueMap.length;i++){
      if(sum <= physiqueMap[i][1]){
        physique = i;
        break;
      }
    }
    print(physique);
    print(iPhysiqueMap[physique]);
    return iPhysiqueMap[physique];
  }


  static int getInvestigatorPropertySum(List<Property> propertyList){
    int sum = 0;
    for(var item in propertyList){
      if(item.name == "LUC"){
        continue;
      }
      sum += item.value;
    }
    return sum;
  }

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
      int rollPoint = 0;
      while(rollPoint<=1){
        rollPoint = Math.Random().nextInt(6);
      }
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

  static int getInvestigatorPropertyValue(Investigator investigator,String propertyName){
    int re = 0;
    investigator.properties.forEach((e)=>{
      if(e.name == propertyName){
          re =  e.value
      }
    });
    return re;
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
        point = e.value * 2
      }
    });
    return point;
  }

  static String _catchString(String catchChar,String str){
    return str.startsWith(catchChar) ? str.substring(catchChar.length) : null;
  }

  static String _catchProperty(String str){

    for (var item in propertyList){
      if(str.startsWith(item.toString())){
        return item;
      }
    }
    return null;
  }


  static int _catchNumber(String str){
    String numberChar = str.substring(0,1);
    return int.parse(numberChar);
  }
  static String _catchEmpty(String str){
    return str.trimLeft();
  }

  static int getSkillPointByRules(String rules,Investigator investigator){
    if(rules.trim() == '') return null;
    String rest = rules.trim();
    int sumPoint = 0;
    int currentPropertyValue = 0;
    int factor = 1;

    while(rest != ''){

      String orRest = _catchString("or", rest);
      if(orRest != null){
        //只可能是属性
        rest = orRest;
        String propertyName = _catchProperty(rest);
        int value = 0;
        investigator.properties.forEach((e)=>{
          if(e.name == propertyName){
            currentPropertyValue = Math.max(e.value,currentPropertyValue)
          }
        });
        rest = _catchString(propertyName, rest);
        continue;
      }
      String addRest = _catchString("+", rest);
      if(addRest !=null){
        //只可能是属性
        rest = _catchEmpty(addRest);
        sumPoint = currentPropertyValue * factor;
        currentPropertyValue = 0;
        factor = 1;
        continue;
      }
      String mulRest = _catchString("*", rest);
      if(mulRest!= null){
        //只可能是数字

        rest = _catchEmpty(mulRest);
        factor = _catchNumber(rest);
        String numberRest = _catchString(factor.toString(),rest);
        rest = _catchEmpty(numberRest);
        continue;
      }
      String propertyName = _catchProperty(rest);
      if(propertyName!=null){
        rest = _catchString(propertyName,rest);
        investigator.properties.forEach((e)=>{
          if(propertyName == e.name){
            currentPropertyValue = e.value
          }
        });

      }
      rest = _catchEmpty(rest);

    }
    sumPoint += currentPropertyValue * factor;

    return sumPoint;
  }




}