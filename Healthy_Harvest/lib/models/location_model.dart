class LocationModel{
  final double? latitude;
  final double? longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJSON(Map<String,double?> json){
    print(json);
    return LocationModel(latitude: json["latitude"], longitude: json["longitude"],);
  }
}