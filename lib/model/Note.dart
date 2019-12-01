import 'Scenario.dart';
class Note{

  int _noteId;
  String _content;
  String _name;
  Scenario _scenario;


  int get noteId => _noteId;

  set noteId(int value) {
    _noteId = value;
  }

  Scenario get scenario => _scenario;

  set scenario(Scenario value) {
    _scenario = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


}