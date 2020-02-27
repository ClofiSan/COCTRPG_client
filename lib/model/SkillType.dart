import 'Skill.dart';

class SkillType {
  int _id;
  String _skillTypeName;
  List<Skill> _skillList;


  SkillType(){
    this._skillList = List();
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get skillTypeName => _skillTypeName;

  List<Skill> get skillList => _skillList;

  set skillList(List<Skill> value) {
    _skillList = value;
  }

  set skillTypeName(String value) {
    _skillTypeName = value;
  }


}