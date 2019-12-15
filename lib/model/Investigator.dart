import 'Note.dart';
import 'Skill.dart';
import 'Occupation.dart';
import 'Property.dart';
//调查员

class Investigator{
  int _HP;
  int _San;
  int _MP;
  int _id;
  String _name;
  int _age;
  int _time;
  Occupation _occupation;
  List<Property>_properties;
  List<Skill> _skills;
  String _background;
  String _imageUrl;
  String _equipment;
  String _international;
  String _language;
  String _foreignName ;
  String _gender;

  List<Note> _noteList = List();


  int get time => _time;

  set time(int value) {
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

  String get equipment => _equipment;

  set equipment(String value) {
    _equipment = value;
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
    return 'Investigator{_id: $_id, _name: $_name, _age: $_age, _occupation: $_occupation, _properties: $_properties, _skills: $_skills, _background: $_background, _imageUrl: $_imageUrl, _equipment: $_equipment}';
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


}