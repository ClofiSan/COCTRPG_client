class BackgroundStory{
  String _personalDescription;
  String _faith;
  String _importantPeople;
  String _extraPlace;
  String _precious;
  String _features;
  String _wound;
  String _mentalIllness;
  String _background;

  Map<String,dynamic> dataToJson() => <String,dynamic>{
  "personal_description":_personalDescription,
  "faith":_faith,
  "important_people":_importantPeople,
  "extra_place":_extraPlace,
  "precious":_precious,
  "features":_features,
  "wound":_wound,
  "mental_illness":_mentalIllness,
  "background":_background
  };
  static BackgroundStory fromJson(Map<String,dynamic> jsonData){
    BackgroundStory backgroundStory = BackgroundStory();
    backgroundStory.personalDescription = jsonData['personal_description'];
    backgroundStory.faith = jsonData['faith'];
    backgroundStory.importantPeople = jsonData['important_people'];
    backgroundStory.extraPlace = jsonData['extra_place'];
    backgroundStory.precious = jsonData['precious'];
    backgroundStory.features = jsonData['features'];
    backgroundStory.wound = jsonData['wound'];
    backgroundStory.mentalIllness = jsonData['mental_illness'];
    backgroundStory.background = jsonData['backgound'];
    return backgroundStory;
  }
  @override
  String toString() {
    return 'BackgroundStory{_personalDescription: $_personalDescription, _faith: $_faith, _importantPeople: $_importantPeople, _extraPlace: $_extraPlace, _precious: $_precious, _features: $_features, _wound: $_wound, _mentalIllness: $_mentalIllness, _background: $_background}';
  }

  String get background => _background;

  set background(String value) {
    _background = value;
  }

  String get mentalIllness => _mentalIllness;

  set mentalIllness(String value) {
    _mentalIllness = value;
  }

  String get wound => _wound;

  set wound(String value) {
    _wound = value;
  }

  String get features => _features;

  set features(String value) {
    _features = value;
  }

  String get precious => _precious;

  set precious(String value) {
    _precious = value;
  }

  String get extraPlace => _extraPlace;

  set extraPlace(String value) {
    _extraPlace = value;
  }

  String get importantPeople => _importantPeople;

  set importantPeople(String value) {
    _importantPeople = value;
  }

  String get faith => _faith;

  set faith(String value) {
    _faith = value;
  }

  String get personalDescription => _personalDescription;

  set personalDescription(String value) {
    _personalDescription = value;
  }


}