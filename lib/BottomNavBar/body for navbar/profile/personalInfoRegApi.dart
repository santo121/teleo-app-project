import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonalInfoRegApi {
  Future<PersonalInfoRegResponse> personalReg(PersonalInfoRegReq req) async {
    final String url = "https://teleoappapi.com/api/data/vendor/profile";
    final response = await http.post(Uri.parse(url),
        body: req.toJson(), headers: req.toHeader());
    if (response.statusCode == 200 || response.statusCode == 400) {
      PersonalInfoRegResponse(statuscode:response.statusCode.toString());
      return PersonalInfoRegResponse.fromJson(json.decode(response.body));
    } else {
      PersonalInfoRegResponse(statuscode:response.statusCode.toString());
      return throw Exception(response.statusCode);
    }
  }
}



class PersonalInfoRegResponse {
  String error, msg,statuscode;
  
  PersonalInfoRegResponse({this.error, this.msg,this.statuscode});
  factory PersonalInfoRegResponse.fromJson(Map<String, dynamic> json) =>
      PersonalInfoRegResponse(
        
        msg: json["msg"] != null ? json["msg"] : null,
        error: json["error"] != null ? json["error"] : null,

      
      );
}

class PersonalInfoRegReq {
  String id,
      vToken,
      ownername,
      altphonenumber,
      email,
      address,
      city,
      state,
      postalcode,
      country;
    
  PersonalInfoRegReq(
      {this.id,
      this.vToken,
      this.address,
      this.altphonenumber,
      this.city,
      this.country,
      this.email,
      
      this.ownername,
      this.postalcode,
      this.state});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "ownername": ownername,
      "altphonenumber": altphonenumber,
      "email": email,
      "address": address,
      "city": city,
      "state": state,
      "postalcode": postalcode,
      "country": country,
     
    };
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> header = {
      "vtoken": vToken.toString(),
      "id": id.toString()
    };
    return header;
  }
}
