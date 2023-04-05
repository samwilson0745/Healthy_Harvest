import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_harvest/models/location_model.dart';
import 'weather_events.dart';
import 'weather_states.dart';
import 'package:healthy_harvest/store/weather/weather_repo.dart';
import 'package:healthy_harvest/models/weather_model.dart';
import 'package:healthy_harvest/store/location/location_repo.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  final weather_repo repo_weather;
  final location_repo repo_location;
  WeatherBloc({required this.repo_weather,required this.repo_location}):super(WeatherInitial()){
    on<GetWeather>((event,emit)async{
      emit(WeatherLoading());
      try{
        LocationModel location = await repo_location.locationService();
        Weather weather = await repo_weather.getWeather(event.key,location.latitude,location.longitude);
        emit(WeatherCompleted(data: weather));
      }catch(e){
        print(e);
        emit(WeatherError(error: e.toString()));
      }
    });

  }




}