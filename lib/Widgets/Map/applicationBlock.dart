import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mallu_vendor/Widgets/Map/geo_location_sevices.dart';



class ApplicationBlock with ChangeNotifier
{

final geoLocationSerivce=GeoLocationSerivce();

Position currentLocation;

ApplicationBlock()
{
  setCurrentLocation();
}

setCurrentLocation()async
{
  currentLocation=await geoLocationSerivce.getCurrentLocation();
  notifyListeners();
}

}