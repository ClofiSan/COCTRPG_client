import 'Investigator.dart';
class User{

  String _id;
  String _name;
  String _imageUrl;

  List<Investigator> _investigatorList;


  User(){
    _investigatorList = List();
  }

  Map<String,dynamic> dataToJson(){
    List<dynamic> iList = investigatorList.map((i) => i.dataToJson()).toList();
    return {
      'id':id,
      'name':name,
      'imageUrl':imageUrl,
      'investigatorList':iList
    };
  }
  static User fromJson(Map<String,dynamic> jsonData){
    User user  = User();
    user.name = jsonData['name'];
    user.id = jsonData['id'];
    user.imageUrl = jsonData['imageUrl'];
    List<Investigator> iList = List();
    for(var item in jsonData['investigatorList']){
      iList.add(Investigator.fromJson(item));
    }
    user.investigatorList = iList;
    return user;
  }

  List<Investigator> get investigatorList => _investigatorList;

  set investigatorList(List<Investigator> value) {
    _investigatorList = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

}