import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:healthy_harvest/config/url_config.dart';
import '../../models/auth_model.dart';

class auth_repo{
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio _dio=Dio();
  Future<bool> hasToken()async{
    var token =await storage.read(key: "token");
    if(token!=null) {
      return true;
    } else {
      return false;
    }
  }
  getToken()async{
    return await storage.read(key: "token");
  }
  getUsername()async{
    return await storage.read(key: "username");
  }
  Future<void> putTokentoStorage(String token)async{
    await storage.write(key: "token", value: token);
  }
  Future<void> putUsernametoStorage(String username)async{
    await storage.write(key: "username", value:username);
  }

  Future<void> deleteToken()async{
    await storage.deleteAll();
  }

  Future<Auth> login(String email,String password)async{
    print(email);
    print(password);
    var response =await _dio.post("${url}/api/user/token",data: {
      "email":email,
      "password":password,
    },options:Options(
      responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      validateStatus: (_)=>true
    ));
    print(response.data);
    return Auth.fromJSON(response.data);
  }
}