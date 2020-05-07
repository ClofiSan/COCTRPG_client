
import 'Attribute.dart';
class Skill extends Attribute  {

  String _description;
  int _initial;
  int _id;
  int _skillTypeId;
  int _haveChildSkill;
  int _interestPoint;
  int _professionalPoint;
  int _growPoint;
  List<Skill> _childSkill = List();

  Map<String,dynamic> dataToJson(){

    List<dynamic> childSkillList = _childSkill.map((i)=>i.dataToJson()).toList();
    return {
      'label':this.label,
      'name':this.name,
      'value':this.value,
      'initial':initial,
      'interest_point':interestPoint,
      'professional_point':professionalPoint,
      'grow_point':growPoint,
      'child_skill':childSkillList,
    };
  }
  static Skill fromJson(Map<String,dynamic> jsonData){
    Skill skill = Skill();
    skill.name = jsonData['name'];
    skill.value = jsonData['value'];
    skill.label = jsonData['label'];
    skill.initial = jsonData['initial'];
    skill.interestPoint = jsonData['interest_point'];
    skill.professionalPoint = jsonData['professional_point'];
    skill.growPoint = jsonData['grow_point'];
    skill.description = jsonData['description'];
    List<Skill> list = List();
    for(var item in jsonData['child_skill']){
      list.add(Skill.fromJson(item));
    }
    skill.childSkill = list;
    return skill;
  }


  @override
  String toString() {
    return 'Skill{_label:$label,_description: $_description, _initial: $_initial, _id: $_id, _skillTypeId: $_skillTypeId, _haveChildSkill: $_haveChildSkill, _interestPoint: $_interestPoint, _professionalPoint: $_professionalPoint, _growPoint: $_growPoint, _childSkill: $_childSkill}';
  }

  Skill(){
    _interestPoint = 0;
    _professionalPoint = 0;
    _growPoint = 0;
  }


  int get interestPoint => _interestPoint;

  set interestPoint(int value) {
    _interestPoint = value;
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