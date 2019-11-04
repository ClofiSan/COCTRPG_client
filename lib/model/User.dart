import 'Note.dart';
class User{

  String _name;
  String _imageUrl;
  Note _note;


  Note get note => _note;

  set note(Note value) {
    _note = value;
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