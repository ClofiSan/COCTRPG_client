class Credit{
  String _livingStandard;
  String _cash;
  String _otherAssets;
  String _consumptionLevel;
  String _assetsDescription;
  int _creditPoint;

  Map<String,dynamic> dataToJson() => <String,dynamic>{
    "living_standard":_livingStandard,
    "cash":_cash,
    "other_assets":otherAssets,
    "consumption_level":consumptionLevel,
    "assets_description":assetsDescription
  };

  static Credit fromJson(Map<String ,dynamic> jsonData){
    Credit credit = Credit();
    credit.livingStandard = jsonData['living_standard'];
    credit.consumptionLevel = jsonData['onsumption_level'];
    credit.cash = jsonData['cash'];
    credit.otherAssets = jsonData['other_assets'];
    credit.assetsDescription = jsonData['assets_description'];
    return credit;
  }

  @override
  String toString() {
    return 'Credit{_livingStandard: $_livingStandard, _cash: $_cash, _otherAssets: $_otherAssets, _consumptionLevel: $_consumptionLevel, _creditPoint: $_creditPoint, _assetsDescription: $_assetsDescription}';
  }

  String get assetsDescription => _assetsDescription;

  set assetsDescription(String value) {
    _assetsDescription = value;
  }

  int get creditPoint => _creditPoint;

  set creditPoint(int value) {
    _creditPoint = value;
  }

  String get livingStandard => _livingStandard;

  set livingStandard(String value) {
    _livingStandard = value;
  }

  String get cash => _cash;

  String get consumptionLevel => _consumptionLevel;

  set consumptionLevel(String value) {
    _consumptionLevel = value;
  }

  String get otherAssets => _otherAssets;

  set otherAssets(String value) {
    _otherAssets = value;
  }

  set cash(String value) {
    _cash = value;
  }


}