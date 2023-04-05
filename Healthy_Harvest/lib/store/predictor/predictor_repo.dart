import 'package:dio/dio.dart';
import 'package:healthy_harvest/models/predictor_model.dart';
import 'package:healthy_harvest/config/url_config.dart';
class predictor_repo {
  final Dio _dio=new Dio();
  Future diagnose(String path)async {
      var formdata = FormData.fromMap({
        "file":await MultipartFile.fromFile(path)
      });
      print(formdata.files);
      try{
        var response = await _dio.post('${url}/api/home/classify',data:formdata,options: Options(
            validateStatus:(status)=>true,
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json'
            }
        )) ;
        print(response);
        return Predictor.fromJson(response.data);
      }catch(e){
        if(e is DioError){
          throw Exception(e);
        }else{
          throw Exception(e);
        }
      }
    }
}
