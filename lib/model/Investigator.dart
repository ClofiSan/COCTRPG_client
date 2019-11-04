import 'Skill.dart';
import 'occupation.dart';
import 'properties.dart';
//调查员

class Investigator{
  int _id;
  String _name;
  int _age;
  Occupation _occupation;
  Properties _properties;
  List<Skill> _skills;
  String _background;
  String _imageUrl;
  String _equipment;


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

  Properties get properties => _properties;

  set properties(Properties value) {
    _properties = value;
  }


}