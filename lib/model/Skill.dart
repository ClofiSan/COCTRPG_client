import 'Attribute.dart';

class Skill extends Attribute{

  String _description;
  int _initial;


  int get initial => _initial;

  set initial(int value) {
    _initial = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }


}