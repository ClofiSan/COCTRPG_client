import 'package:flutter/material.dart';

import 'Note.dart';
import 'Skill.dart';
import 'Occupation.dart';
import 'Property.dart';
import 'SkillType.dart';
import 'Weapon.dart';
//调查员

class Investigator with ChangeNotifier{
  int _HP;
  int _San;
  int _MP;
  int _MOV;
  int _Phy;
  String _dmagePlus;
  int _id;
  String _name;
  int _age;
  String _time;
  Occupation _occupation;
  List<Property>_properties;
  List<Skill> _skills;
  String _background;
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

  @override
  String toString() {
    return 'Investigator{_id: $_id, _name: $_name, _age: $_age, _occupation: $_occupation, _properties: $_properties, _skills: $_skills, _background: $_background, _imageUrl: $_imageUrl}';
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get background => _background;

  set background(String value) {
    _background = value;
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

  String get dmagePlus => _dmagePlus;

  set dmagePlus(String value) {
    _dmagePlus = value;
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