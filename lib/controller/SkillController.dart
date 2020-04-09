import 'package:dio/dio.dart';
import 'package:coc_trpg/config.dart';
import 'package:yaml/yaml.dart' as YAML;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:coc_trpg/model/Skill.dart';
import 'package:coc_trpg/model/SkillType.dart';
class SkillController{

  List<String> _skillTypeList = ["交际类","移动类","隐秘类","学问类","调查类","医疗类","战斗类别","职业技能类"];
  List<SkillType> _allSkill ;



  SkillController(){
    _allSkill = List();

  }

  loadSkills() async{
    var _skillsJson = await _loadSkillJson();
    for(var sameTypeSkill in _skillsJson){
      SkillType skillType = SkillType();
      skillType.skillTypeName = sameTypeSkill['skillType'];
      List<Skill> skillList = List();
      for(var skillItem in sameTypeSkill['contains']){
        Skill skill = Skill();
        skill.label = skillItem['label'];
        skill.description = skillItem['description'];
        skill.initial = skillItem['initial'];
        skill.value = skill.initial;
        if(skillItem['contains']!=null){
          List<Skill> childSkillList = List();
          for(var childSkillItem in skillItem['contains']){
            Skill childSkill = Skill();
            childSkill.label = childSkillItem['label'];
            childSkill.description = childSkillItem['description'];
            childSkill.initial = childSkillItem['initial'];
            childSkill.value = childSkill.initial;
            childSkillList.add(childSkill);
          }
          skill.childSkill = childSkillList;
        }
        skillList.add(skill);
      }
      skillType.skillList = skillList;
      _allSkill.add(skillType);
    }
  }

  _loadSkillJson() async {
    var data = await rootBundle.loadString('assets/NewSkills.json');
    return json.decode(data);
  }
  getAllSkill(){
    return _allSkill;
  }
  getAllSkillType(){
    return _skillTypeList;
  }







}































