 import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object?> get props => [];
}
class GetWeather extends WeatherEvent {
  final String key;

  const GetWeather({required this.key,});
  @override
  List<Object?> get props => [key];

  @override
  String toString()=>"Get Weather for";
}