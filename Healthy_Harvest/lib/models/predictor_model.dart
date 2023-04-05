import 'package:dio/dio.dart';

class Predictor{
  final Map<String,dynamic> args;
  Predictor(this.args);
  Predictor.fromJson(Map<String,dynamic> json):args=json;
}