import 'package:dio/dio.dart';
import 'package:coc_trpg/config.dart';

class OccupationController{

  static getAllOccupation() async{
    try{
      var baseOpition = BaseOptions(
          baseUrl: Config.url,
          headers: {
          "Content-Type":"application/x-www-form-urlencoded;charset=utf-8"
        }
      );
      var dio = new Dio(baseOpition);
      var response = await dio.get(Config.loadAllOccupationApi);
      if (response.data['code'] == 200){
        return response.data['obj'];
      }
    }catch(e){
      print(e);
    }
  }

}