import 'package:geolocator/geolocator.dart';

class GeoLocationSerivce {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high); 
  }
}
