import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:coc_trpg/model/Weapon.dart';
class WeaponController{
  Map<String,List<Weapon>> _weaponMap;
  final List<String> _weaponTypeList = [
    "常规武器",
    "手枪",
    "步枪/霰弹枪",
    "冲锋枪",
    "机关枪",
    "其他武器"
  ];



  WeaponController(){
    _weaponMap = Map();
  }

  _loadWeaponsJson()async{
    var data = await rootBundle.loadString('assets/weapons.json');
    return json.decode(data);
  }

  loadWeapons()async{
    var weaponJson = await _loadWeaponsJson();
    for(int i=0;i<_weaponTypeList.length;i++){
      List<Weapon> sameWeapon = List();
      for(var item in weaponJson[_weaponTypeList[i]]){
        Weapon weapon = Weapon();
        weapon.name = item["武器类型"];
        weapon.relevantSkill = item["技能"];
        weapon.damage = item["伤害"];
        weapon.puncture = item["穿刺"];
        weapon.frequency = item["次数"];
        weapon.capasity = item["装弹量"];
        weapon.breakdown = item["故障值"];
        weapon.price = item["价格20s/现代(\$)"];
        weapon.time = item["常见年代"];
        sameWeapon.add(weapon);
      }
      _weaponMap[_weaponTypeList[i]] = sameWeapon;

    }
  }

  getAllWeapon(){
    return _weaponMap;
  }
  getWeaponType(){
    return _weaponTypeList;
  }


}