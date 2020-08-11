import 'package:coc_trpg/model/Investigator.dart';
import 'package:flutter/material.dart';
import 'package:coc_trpg/model/SkillType.dart';
import 'package:coc_trpg/model/Skill.dart';
class CreateInvestigatorStore with ChangeNotifier{
  Investigator _investigator;

  void changeSkillValue(String skillLabel,int proPoint,int interestedPoint,int growPoint){
    for(var skills in investigator.allSkill){
      for(var item in skills.skillList){
        if(item.label == skillLabel){
          item.professionalPoint = proPoint;
          item.interestPoint = interestedPoint;
          item.growPoint = growPoint;
        }
      }
    }
    notifyListeners();
  }

  void setInterestedPoint(int point){
    _investigator.interestedPoint = point;
    notifyListeners();
  }
  void setProPoint(int point){
    _investigator.proPoint = point;
    notifyListeners();
  }

  void changeAllSkill(List<SkillType> allSkills){
    _investigator.allSkill = allSkills;
    notifyListeners();
  }



  CreateInvestigatorStore(){
    _investigator = Investigator();
  }

  Investigator get investigator => _investigator;

  set investigator(Investigator value) {
    _investigator = value;
    notifyListeners();
  }
  String a = "111";

  void changeA(ss){
    a = ss;
    notifyListeners();
  }


}