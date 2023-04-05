import 'package:equatable/equatable.dart';
import 'package:healthy_harvest/models/weather_model.dart';

abstract class WeatherState extends Equatable{
  @override
  List<Object> get props=>[];
}

class WeatherInitial extends WeatherState{

}

class WeatherLoading extends WeatherState{

}

class WeatherCompleted extends WeatherState{
  final Weather data;
  WeatherCompleted({required this.data});
  @override
  List<Object> get props =>[data];
}

class WeatherError extends WeatherState{
 final String error;
  WeatherError({required this.error});
  @override
  List<Object> get props => [error];

  String toString()=>'Weather Error: $error';
}