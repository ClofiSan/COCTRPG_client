class Attribute{
  String _label;
  String _name;
  int _value;


  @override
  String toString() {
    return 'Property{_label: $_label, _name: $_name, _value: $_value}';
  }

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