import 'Skill.dart';
class Occupation{
  int _id;
  String _name;//id
  int _skillPoint;
  int _minCredit;
  int _maxCredit;
  String _skillList;
  String _description;
  String _skillPointRule;


  int get minCredit => _minCredit;

  set minCredit(int value) {
    _minCredit = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get skillPointRule => _skillPointRule;

  set skillPointRule(String value) {
    _skillPointRule = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get skillPoint => _skillPoint;

  set skillPoint(int value) {
    _skillPoint = value;
  }

  int get maxCredit => _maxCredit;

  set maxCredit(int value) {
    _maxCredit = value;
  }

  String get skillList => _skillList;

  set skillList(String value) {
    _skillList = value;
  }


}
