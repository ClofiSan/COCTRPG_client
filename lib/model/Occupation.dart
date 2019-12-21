import 'Skill.dart';
class Occupation{
  String _name;//id
  int _skillPoint;
  List<dynamic> _credit;
  List<Skill> _skills;
  String _description;
  String _skillPointRule;


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

  List<Skill> get skills => _skills;

  set skills(List<Skill> value) {
    _skills = value;
  }

  List<dynamic> get credit => _credit;

  set credit(List<dynamic> value) {
    _credit = value;
  }

  set skillPoint(int value) {
    _skillPoint = value;
  }


}
