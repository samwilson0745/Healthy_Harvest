import 'dart:convert';

import 'package:healthy_harvest/models/location_model.dart';
import 'package:location/location.dart' as Location;
import 'package:geocoding/geocoding.dart' as geoCoder;

class location_repo{
  Map<String,double?> data={};

  Future locationService()async{
    Location.Location location = new Location.Location();
    bool _serviceEnabled;
    Location.PermissionStatus _permissionLocation;
    Location.LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if(_permissionLocation != Location.PermissionStatus.denied){
      _permissionLocation = await location.requestPermission();
      if(_permissionLocation != Location.PermissionStatus.granted){
        return;
      }
    }

    _locData = await location.getLocation();
    var address = await geoCoder.placemarkFromCoordinates(_locData.latitude!, _locData.longitude!).then((value) {
      print(value[2].locality);
      data={
        "latitude":_locData.latitude!,
        "longitude":_locData.longitude!
      };
    });

    return LocationModel.fromJSON(data);
  }
}