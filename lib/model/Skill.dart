import 'Attribute.dart';

class Skill extends Attribute{

  String _description;
  int _initial;
  int _id;
  int _skillTypeId;
  int _haveChildSkill;


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get initial => _initial;

  set initial(int value) {
    _initial = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  int get skillTypeId => _skillTypeId;

  set skillTypeId(int value) {
    _skillTypeId = value;
  }

  int get haveChildSkill => _haveChildSkill;

  set haveChildSkill(int value) {
    _haveChildSkill = value;
  }


}