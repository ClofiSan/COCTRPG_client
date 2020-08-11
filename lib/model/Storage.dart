import 'package:path_provider/path_provider.dart';
import 'dart:io';
class Storage {
  String _fileName;

  Storage(this._fileName);

  String get fileName => _fileName;

  set fileName(String value) {
    _fileName = value;
  }

  Future<String> get _localPath async {
//    final _path = await getTemporaryDirectory();
    final _path = await  getApplicationDocumentsDirectory();
    print(_path.path);
    return _path.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File(path+fileName);
  }

  Future<String> readFile() async{
    try {
      final file = await _localFile;
      var contents = await file.readAsString();
      return contents;
    } catch (e) {
      print(e);
    }
  }
  Future<File> writeFile(String content) async {
    final file = await _localFile;

    return file.writeAsString(content);
  }
}
