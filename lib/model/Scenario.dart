import 'NPC.dart';
class Scenario{
  String _id;
  String _name;
  String _description;
  List<NPC> _NPCList ;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<NPC> get NPCList => _NPCList;

  set NPCList(List<NPC> value) {
    _NPCList = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }


}