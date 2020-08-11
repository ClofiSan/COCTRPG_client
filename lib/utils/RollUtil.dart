import 'dart:math' as Math;
/*
* todo:roll 点
* */

class RollUtil{
  static Map<int,String> Roll1D100(int value){
    int rollPoint = Math.Random().nextInt(100);
    String des = "";
    if(rollPoint>=97){
      des = "大失败！";
    }else if(rollPoint<=3){
      des = "大成功！";
    }else if(rollPoint <= value){
      des = "成功";
    } else if(rollPoint > value){
      des = "失败";
    }
    Map<int,String> result = Map();
    result[rollPoint] = des;
    print(result.toString());
    return result;
  }
}