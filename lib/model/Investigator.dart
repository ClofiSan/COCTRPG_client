import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Note.dart';
import 'Skill.dart';
import 'Occupation.dart';
import 'Property.dart';
import 'SkillType.dart';
import 'Weapon.dart';
import 'BackgroundStory.dart';
import 'Credit.dart';
import 'dart:convert';

//调查员
@JsonSerializable()
class Investigator with ChangeNotifier{
  int _HP;
  int _San;
  int _MP;
  int _MOV;
  int _Phy;
  String _damagePlus;
  int _id;
  String _name;
  int _age;
  String _time;

  Occupation _occupation;
  List<Property>_properties;
  List<Skill> _skills;
  String _imageUrl;

  String _international;
  String _language;
  String _foreignName ;
  String _gender;

  String _location;
  String _hometown;

  List<SkillType> _allSkill;

  List<Note> _noteList = List();
  int _interestedPoint ;
  int _proPoint ;

  List<String> _equitpments;
  List<Weapon> _weaponList;

  BackgroundStory _backgroundStory;

  Credit _credit;

  Map<String,dynamic> dataToJson(){
    List<dynamic> weaponList = _weaponList.map((i) => i.dataToJson()).toList();
    List<dynamic> allSkills = _allSkill.map((i) => i.dataToJson()).toList();
    List<dynamic> pList = properties.map((i) => i.dataToJson()).toList();
    List<dynamic> slist = skills.map((i)=> i.dataToJson()).toList();

    return {
      'id':_id,
      'name':_name,
      'age':_age,
      "gender":_gender,
      'time':_time,
      'international':_international,
      'location':_location,
      'hometown':_hometown,
      'image_url':_imageUrl,
      'HP':_HP,
      'MP':_MP,
      'San':_San,
      'MOV':_MOV,
      "Phy":_Phy,
      'damage_plus':_damagePlus,

      'background_story':_backgroundStory.dataToJson(),
      'occupation':_occupation.dataToJson(),
      'credit':_credit.dataToJson(),

      'properties':pList,
      'weapons':weaponList,
      'equipments':equitpments,
      'skill_types':allSkills,
      'skills':slist
    };
  }
  static Investigator fromJson(Map<String,dynamic> jsonData){
    Investigator investigator = Investigator();
    investigator.id = jsonData['id'];
    investigator.name = jsonData['name'];
    investigator.age = jsonData['age'];
    investigator.gender = jsonData['gender'];
    investigator.time = jsonData['time'];
    investigator.international= jsonData['international'];
    investigator.location = jsonData['location'];
    investigator.hometown = jsonData['hometown'];
    investigator.HP = jsonData['HP'];
    investigator.MP = jsonData['MP'];
    investigator.San = jsonData['San'];
    investigator.MOV = jsonData['MOV'];
    investigator.Phy = jsonData['Phy'];
    investigator.damagePlus = jsonData['damage_plus'];

    investigator.credit = Credit.fromJson(jsonData['credit']);
    investigator.occupation = Occupation.fromJson(jsonData['occupation']);
    investigator.backgroundStory = BackgroundStory.fromJson(jsonData['background_story']);

    List<Property> pList = List();
    for(var item in jsonData['properties']){
      pList.add(Property.fromJson(item));
    }
    investigator.properties = pList;

    List<Weapon> wList = List();
    for(var item in jsonData['weapons']){
      wList.add(Weapon.fromJson(item));
    }
    investigator.weaponList = wList;

    List<String> elist = List();
    for(var item in jsonData['equipments']){
      elist.add(item.toString());
    }
    investigator.equitpments = elist;

    List<SkillType> stList = List();
    for(var item in jsonData['skill_types']){
      stList.add(SkillType.fromJson(item));
    }
    investigator.allSkill = stList;

    List<Skill> sList = List();
    for(var item in jsonData['skills']){
      sList.add(Skill.fromJson(item));
   }
    investigator._skills = sList;


    return investigator;
  }

  @override
  String toString() {
    return 'Investigator{_HP: $_HP, _San: $_San, _MP: $_MP, _MOV: $_MOV, _Phy: $_Phy, _damagePlus: $_damagePlus, _id: $_id, _name: $_name, _age: $_age, _time: $_time, _occupation: $_occupation, _properties: $_properties, _skills: $_skills, _imageUrl: $_imageUrl, _international: $_international, _language: $_language, _foreignName: $_foreignName, _gender: $_gender, _location: $_location, _hometown: $_hometown, _allSkill: $_allSkill, _noteList: $_noteList, _interestedPoint: $_interestedPoint, _proPoint: $_proPoint, _equitpments: $_equitpments, _weaponList: $_weaponList, _backgroundStory: $_backgroundStory, _credit: $_credit}';
  }

  Credit get credit => _credit;

  set credit(Credit value) {
    _credit = value;
  }

  BackgroundStory get backgroundStory => _backgroundStory;

  set backgroundStory(BackgroundStory value) {
    _backgroundStory = value;
  }

  List<String> get equitpments => _equitpments;

  set equitpments(List<String> value) {
    _equitpments = value;
  }

  int get interestedPoint => _interestedPoint;


  set interestedPoint(int value) {
    _interestedPoint = value;
  }

  Investigator(){
    _properties = List();
    _allSkill = List();
  }




  List<SkillType> get allSkill => _allSkill;

  set allSkill(List<SkillType> value) {
    _allSkill = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  int get MOV => _MOV;

  set MOV(int value) {
    _MOV = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }




  int get HP => _HP;

  set HP(int value) {
    _HP = value;
  }

  List<Note> get noteList => _noteList;

  set noteList(List<Note> value) {
    _noteList = value;
  }

  Occupation get occupation => _occupation;

  set occupation(Occupation value) {
    _occupation = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  List<Skill> get skills => _skills;

  set skills(List<Skill> value) {
    _skills = value;
  }

  List<Property> get properties => _properties;

  set properties(List<Property> value) {
    _properties = value;
  }

  int get San => _San;

  set San(int value) {
    _San = value;
  }

  int get MP => _MP;

  set MP(int value) {
    _MP = value;
  }

  String get international => _international;

  set international(String value) {
    _international = value;
  }

  String get foreignName => _foreignName;

  set foreignName(String value) {
    _foreignName = value;
  }

  String get language => _language;

  set language(String value) {
    _language = value;
  }

  int get Phy => _Phy;

  set Phy(int value) {
    _Phy = value;
  }

  String get damagePlus => _damagePlus;

  set damagePlus(String value) {
    _damagePlus = value;
  }

  String get hometown => _hometown;

  set hometown(String value) {
    _hometown = value;
  }

  int get proPoint => _proPoint;

  set proPoint(int value) {
    _proPoint = value;
  }

  List<Weapon> get weaponList => _weaponList;

  set weaponList(List<Weapon> value) {
    _weaponList = value;
  }


}