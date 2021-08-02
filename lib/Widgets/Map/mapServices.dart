import 'dart:convert';
import 'package:http/http.dart' as http;
class MapServices {

  Future<MapServicesResponce>uploadLatLong(MapServicesRiquest req)async
  {
    String url ="https://teleoappapi.com/api/data/vendor/location";
    final response = await http.post(Uri.parse(url),body: req.toJson(),headers: req.toHeader());

    if(response.statusCode==200||response.statusCode==400)
    {
      return MapServicesResponce.fromJson(json.decode(response.body));
    }
    else{return throw Exception(response.statusCode);}

  }
}

class MapServicesResponce {
  String error, msg;

  MapServicesResponce({this.error, this.msg});
  factory MapServicesResponce.fromJson(Map<String, dynamic> json) {
    return MapServicesResponce(
      error: json["error"] != null ? json["error"] : null,
      msg: json["msg"] != null ? json["msg"] : null,
    );
  }
}

class MapServicesRiquest {
  String latitude,
      longitude,
      address,
      streetname,
      landmark,
      vendorToken,
      vendorId;
  MapServicesRiquest(
      {this.address,
      this.landmark,
      this.latitude,
      this.longitude,
      this.streetname});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "streetname": streetname,
      "landmark": streetname
    };
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}
