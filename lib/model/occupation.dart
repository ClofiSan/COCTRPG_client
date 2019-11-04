import 'Skill.dart';
class Occupation{
  String _name;//id
  int _skillPoint;
  List<int> _credit;
  List<Skill> _skills;


  Occupation(this._name, this._skillPoint, this._credit, this._skills);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get skillPoint => _skillPoint;

  List<Skill> get skills => _skills;

  set skills(List<Skill> value) {
    _skills = value;
  }

  List<int> get credit => _credit;

  set credit(List<int> value) {
    _credit = value;
  }

  set skillPoint(int value) {
    _skillPoint = value;
  }


}
