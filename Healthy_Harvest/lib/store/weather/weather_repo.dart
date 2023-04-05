import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:healthy_harvest/models/weather_model.dart';

class weather_repo{
 final Dio _dio = new Dio();

 Future <Weather> getWeather(String key, double? latitude,double? longitude)async{
   final queryParameters ={
     'lat': latitude,
     'lon':longitude,
     'appid':key,
   };
   var response = await _dio.get('https://api.openweathermap.org/data/2.5/weather',
       options: Options (
         validateStatus: (_) => true,
         contentType: Headers.jsonContentType,
         responseType:ResponseType.json,
       ),
       queryParameters: queryParameters);
   print(response);
   return Weather.fromJSON(response.data);
 }
}