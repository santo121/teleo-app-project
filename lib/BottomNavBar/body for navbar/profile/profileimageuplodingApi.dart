import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart' as mime;



class ProfileImageUplodingApi{
final String url = "https://teleoappapi.com/api/data/vendor/profile/image";
Future<dynamic> service (ProfileImageUplodingApiRequest req,filepath)async
{
  final request = http.MultipartRequest('POST',Uri.parse(url));
   request.files.add(await http.MultipartFile.fromPath("file",filepath,contentType: mime.MediaType('image','jpeg')));
    request.headers.addAll(req.toHeader());
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print(responseString);
    if(response.statusCode==200){
      return response.statusCode;

    }else{
      return response.statusCode;
    }  
}
}


class ProfileImageUplodingApiRequest {
  String 
      vendorToken,
      vendorId;
 ProfileImageUplodingApiRequest(
      {
      this.vendorToken,this.vendorId
      });
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}