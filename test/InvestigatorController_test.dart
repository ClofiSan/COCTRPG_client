import 'package:flutter_test/flutter_test.dart';
import 'package:coc_trpg/controller/InvestigatorController.dart';
import 'package:coc_trpg/model/Investigator.dart';
import 'dart:math' as Math;
import 'dart:convert';
import 'package:flutter/services.dart';
void main(){

  group("test investigatorController :", (){
    Investigator investigator = Investigator();
    investigator.properties = InvestigatorController.loadRandomPropertyList();

    test("EDU * 4",(){
      int result = 0;
      investigator.properties.forEach((e)=>{
        if(e.name == "EDU"){
          result = e.value * 4
          }
      });
      expect(InvestigatorController.getSkillPointByRules("EDU * 4\n", investigator), result);
    });

    test("EDU * 2 + DEX * 2",(){
      int result = 0;
      int edu = 0;
      int dex = 0;
      investigator.properties.forEach((e)=>{
        if(e.name == "EDU"){
          edu = e.value
        }else if(e.name == "DEX"){
          dex = e.value
        }
      });
      result = edu*2+dex*2;
      expect(InvestigatorController.getSkillPointByRules("EDU * 2 + DEX * 2\n", investigator), result);

    });

    test("EDUorDEX * 4",(){
      int result = 0;
      int edu = 0;
      int dex = 0;
      investigator.properties.forEach((e)=>{
        if(e.name == "EDU"){
          edu = e.value
        }else if(e.name == "DEX"){
          dex = e.value
        }
      });
      result = Math.max(edu, dex)*4;
      expect(InvestigatorController.getSkillPointByRules("EDUorDEX * 4\n", investigator), result);
    });

    test("EDU * 2 + STRorDEX * 2 ",(){
      int result = 0;
      int edu = 0;
      int dex = 0;
      int str = 0;
      investigator.properties.forEach((e)=>{
        if(e.name == "EDU"){
          edu = e.value
        }else if(e.name == "DEX"){
          dex = e.value
        }else if(e.name == "STR"){
          str = e.value
        }
      });
      result = edu * 2 + Math.max(str, dex)*2;
      expect(InvestigatorController.getSkillPointByRules("EDU * 2 + STRorDEX * 2\n", investigator), result);
    });

    test("EDU * 2 + APPorPOW * 2 ",(){
      int result = 0;
      int edu = 0;
      int app = 0;
      int pow = 0;
      investigator.properties.forEach((e)=>{
        if(e.name == "EDU"){
          edu = e.value
        }else if(e.name == "APP"){
          app = e.value
        }else if(e.name == "POW"){
          pow = e.value
        }
      });
      result = edu * 2 + Math.max(pow, app)*2;
      expect(InvestigatorController.getSkillPointByRules("EDU * 2 + APPorPOW * 2\n", investigator), result);
    });

    test("test json to model", () async{


    });


  });
}