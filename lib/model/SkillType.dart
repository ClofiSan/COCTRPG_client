import 'Skill.dart';

class SkillType {
  int _id;
  String _skillTypeName;
  List<Skill> _skillList;


  Map<String,dynamic> dataToJson(){
    List<dynamic> list = _skillList.map((i)=>i.dataToJson()).toList();
    return {
      "skill_type_name":skillTypeName,
      "skill_list":list
    };
  }
  static SkillType fromJson(Map<String ,dynamic> jsonData){
    SkillType skillType = SkillType();
    skillType.skillTypeName = jsonData['skill_type_name'];
    List<Skill> list = List();
    for(var item in jsonData['skill_list']){
      list.add(Skill.fromJson(item));
    }
    skillType.skillList = list;
    return skillType;
  }

  @override
  String toString() {
    return 'SkillType{_id: $_id, _skillTypeName: $_skillTypeName, _skillList: $_skillList}';
  }

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