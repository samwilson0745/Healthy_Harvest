class Weather{
  final double temperature_C;
  final double temperature_F;
  final double wind_kph;
  final int humidity;
  final double uv;
  final String city;
  final String country;
  Weather({
    this.temperature_C=0,
    this.temperature_F=0,
    this.humidity=0,
    this.uv=0,
    this.wind_kph=0,
    this.city='',
    this.country=''
  });

  factory Weather.fromJSON(Map<String,dynamic> json){
    print(json["main"]);
    return Weather(
      temperature_C: json["main"]["temp"],
      humidity: json["main"]["humidity"],
      wind_kph: json["wind"]["speed"],
      city: json["name"]
    );
  }
}