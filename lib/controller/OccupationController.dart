import 'package:dio/dio.dart';
import 'package:coc_trpg/config.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:coc_trpg/model/Occupation.dart';
class OccupationController{


  List<Occupation> _occupationList;

  OccupationController(){
    _occupationList = List();
  }

  loadAllOccupation() async{
    var _occupationJson = await _loadAllOccupationJson();
    for(var item in _occupationJson){
      Occupation occupation = Occupation();
      occupation.name = item["name"];
      occupation.skillPointRule = item["skillPoint"];
      occupation.skillList = item["skills"];
      occupation.minCredit = item["credit"][0];
      occupation.maxCredit = item["credit"][1];
      _occupationList.add(occupation);
    }
  }
  _loadAllOccupationJson() async{
    var data = await rootBundle.loadString("assets/occupations.json");
    return json.decode(data);
  }

  getAllOccupationList(){
    return _occupationList;
  }




}