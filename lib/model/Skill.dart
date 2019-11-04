class Skill{
  String _label;
  String _name; //id
  int _value;

  Skill(this._label, this._name, this._value);

  int get value => _value;

  set value(int value) {
    _value = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get label => _label;

  set label(String value) {
    _label = value;
  }


}