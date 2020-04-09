import 'Attribute.dart';

class Skill extends Attribute{

  String _description;
  int _initial;
  int _id;
  int _skillTypeId;
  int _haveChildSkill;
  int _interestPoint;
  int _professionalPoint;
  int _growPoint;
  List<Skill> _childSkill = List();


  int get interestPoint => _interestPoint;

  set interestPoint(int value) {
    _interestPoint = value;
  }

  @override
  String toString() {
    return 'Skill{_description: $_description, _initial: $_initial, _id: $_id, _skillTypeId: $_skillTypeId, _haveChildSkill: $_haveChildSkill, _childSkill: $_childSkill}';
  }



  List<Skill> get childSkill => _childSkill;

  set childSkill(List<Skill> value) {
    _childSkill = value;
  }

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

  int get professionalPoint => _professionalPoint;

  set professionalPoint(int value) {
    _professionalPoint = value;
  }

  int get growPoint => _growPoint;

  set growPoint(int value) {
    _growPoint = value;
  }


}