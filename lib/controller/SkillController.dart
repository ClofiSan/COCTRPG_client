import 'package:dio/dio.dart';
import 'package:coc_trpg/config.dart';
class SkillController{

  static List<String> _skillTypeList = ["交际","移动","隐秘","学问","调查","医疗","战斗","职业技能","语言"];

  static getAllSkills() async{
    try{
      var baseOpition = BaseOptions(
          baseUrl: Config.url,
          headers: {
            "Content-Type":"application/x-www-form-urlencoded;charset=utf-8"
          }
      );
      var dio = new Dio(baseOpition);
      var response = await dio.get(Config.loadAllSkillApi);
      if(response.data['code'] == 200){
        return response.data['obj'];
      }
    }catch (e){
      print(e);
    }
  }
  static getAllSkillType() {
    return _skillTypeList;
  }
  static getSameTypeSkills(int skillTypeId) async{
    try{
      var baseOpition = BaseOptions(
          baseUrl: Config.url,
          headers: {
            "Content-Type":"application/x-www-form-urlencoded;charset=utf-8"
          }
      );
      var dio = new Dio(baseOpition);
      var response = await dio.get(Config.loadSameTypeSkills,queryParameters: {"skillTypeId":skillTypeId});
      if(response.data['code'] == 200){
        return response.data['obj'];
      }
    }catch (e){
      print(e);
    }
  }
}