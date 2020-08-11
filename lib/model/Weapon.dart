class Weapon{
  String _name;
  String _relevantSkill;
  String _damage;
  String _range;//射程
  String _puncture;//穿刺
  String _frequency;//次数
  String _capasity;//装弹量
  String _breakdown;//故障值
  String _time;//常见时代
  String _price;

  Map<String,dynamic> dataToJson() => <String,dynamic>{
  'name':_name,
  'relevant_skill':_relevantSkill,
  'damage':_damage,
  'range':_range,
  'puncture':_puncture,
  'frequency':_frequency,
  'capasity':_capasity,
  'breakdown':_breakdown,
  'time':_time,
  'price':_price
  };

  static Weapon fromJson(Map<String ,dynamic> jsonData){
    Weapon weapon = Weapon();
    weapon.name = jsonData['name'];
    weapon.range  = jsonData['range'];
    weapon.relevantSkill = jsonData['relevant_skill'];
    weapon.damage = jsonData['damage'];
    weapon.puncture = jsonData['puncture'];
    weapon.frequency = jsonData['frequency'];
    weapon.capasity = jsonData['capasity'];
    weapon.breakdown = jsonData['breakdown'];
    weapon.time = jsonData['time'];
    weapon.price = jsonData['price'];
    return weapon;
  }


  @override
  String toString() {
    return 'Weapon{_name: $_name, _relevantSkill: $_relevantSkill, _damage: $_damage, _range: $_range, _puncture: $_puncture, _frequency: $_frequency, _capasity: $_capasity, _breakdown: $_breakdown, _time: $_time, _price: $_price}';
  } //价格


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get relevantSkill => _relevantSkill;

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get breakdown => _breakdown;

  set breakdown(String value) {
    _breakdown = value;
  }

  String get capasity => _capasity;

  set capasity(String value) {
    _capasity = value;
  }

  String get frequency => _frequency;

  set frequency(String value) {
    _frequency = value;
  }

  String get puncture => _puncture;

  set puncture(String value) {
    _puncture = value;
  }

  String get range => _range;

  set range(String value) {
    _range = value;
  }

  String get damage => _damage;

  set damage(String value) {
    _damage = value;
  }

  set relevantSkill(String value) {
    _relevantSkill = value;
  }


}