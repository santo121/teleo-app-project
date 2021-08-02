import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class OtpServices {
  Future<OtpResponces> login(OtpRequest request, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
      String url = "https://teleoappapi.com/api/auth/vendor/verifylogin";
      final response = await http.post(Uri.parse(url),
          body: request.toJson(), headers: request.toHeader());
      if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 500) {
        return OtpResponces.fromJson(json.decode(response.body));
      } else {
        return OtpResponces.fromJson(json.decode(response.body));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No InterNet Conection"),
                content: Text("check internet connection"), 
              ));
    }
  }
}

class OtpResponces {
  OtpResponces({this.msg, this.id, this.store, this.error,this.storename});
  String msg;
  String id;
  String error;
  String store,storename; 

  factory OtpResponces.fromJson(Map<String, dynamic> json) => OtpResponces(
      msg: json["msg"] != null ? json["msg"] : null,
      id: json["id"] != null ? json["id"] : null,
      store: json["store"] != null ? json["store"] : null,
      storename: json["storename"]!=null? json["storename"]:null,
      error: json['error']!=null?json["error"]:null
      );
}

class OtpRequest { 
  String token, vToken;
  OtpRequest({this.token, this.vToken});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"token": token.toString()};
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> header = {"vtoken": vToken.toString()};
    return header;
  }
}

internetChecker() async {
  // Simple check to see if we have internet
  print("The statement 'this machine is connected to the Internet' is: ");
  print(await DataConnectionChecker().hasConnection);
  // returns a bool

  // We can also get an enum instead of a bool
  print("Current status: ${await DataConnectionChecker().connectionStatus}");
  // prints either DataConnectionStatus.connected
  // or DataConnectionStatus.disconnected

  // This returns the last results from the last call
  // to either hasConnection or connectionStatus
  print("Last results: ${DataConnectionChecker().lastTryResults}");

  // actively listen for status updates
  DataConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case DataConnectionStatus.connected:
        print('Data connection is available.');
        break;
      case DataConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        break;
    }
  });

  // close listener after 30 seconds, so the program doesn't run forever

  return await DataConnectionChecker().connectionStatus;
}
