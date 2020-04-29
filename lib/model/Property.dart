import 'Attribute.dart';
class Property extends Attribute{
  Property();

  Map<String,dynamic> dataToJson() => <String,dynamic>{
    'label': label,
    'name': name,
    'value': value,
  };

  static Property fromJson(Map<String,dynamic> jsonData){
    Property property = Property();
    property.name = jsonData['name'];
    property.label = jsonData['label'];
    property.value = jsonData['value'];
    return property;
  }
}