import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:healthy_harvest/config/url_config.dart';
import 'package:healthy_harvest/models/register_model.dart';

class register_repo{
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio _dio = Dio();
  Future register(String username,String email,String password)async{
    var formData = FormData.fromMap({
      "username":username,
      "email":email,
      "password":password,
    });
    try{
      var response =await _dio.post("${url}/api/user/register",data: formData,options:Options(
          validateStatus:(status)=>true,
          headers: {
            'Content-type': 'multipart/form-data',
            'Accept': 'application/json'
          }
      ));
      return Register.fromJSON(response.data);
    }catch(e){
      return e;
    }
  }
  Future<void> putIdStorage(String id)async{
    await storage.write(key:'id',value:id);
  }
}