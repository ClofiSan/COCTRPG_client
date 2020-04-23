class Credit{
  String _livingStandard;
  String _cash;
  String _otherAssets;
  String _consumptionLevel;
  int _creditPoint;
  String _assetsDescription;


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