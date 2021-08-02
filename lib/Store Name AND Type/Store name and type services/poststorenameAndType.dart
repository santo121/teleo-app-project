import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopNameAndStorePostService {
  Future<ShopNameAndStorePostResponce> postStorename(
      ShopNameAndStorePostRequest request, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
      String url = "https://teleoappapi.com/api/data/vendor/startprofile";
      final response = await http.post(Uri.parse(url),
          body: request.toJson(), headers: request.toHeader());
      if (response.statusCode == 200||response.statusCode==400) {
        return ShopNameAndStorePostResponce.fromjson(json.decode(response.body));
      } else {
        return throw Exception(response.statusCode);
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

class ShopNameAndStorePostRequest {
  String storeType, storename, vtoken, id;
  ShopNameAndStorePostRequest(
      {this.storeType, this.storename, this.vtoken, this.id});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"storename": storename, "storetype": storeType};
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> header = {"vtoken": vtoken, "id": id};
    return header;
  }
}

class ShopNameAndStorePostResponce {
  String msg;
  String error;
  ShopNameAndStorePostResponce({this.msg, this.error});
  factory ShopNameAndStorePostResponce.fromjson(Map<String, dynamic> json) {
    return ShopNameAndStorePostResponce(
        error: json["error"] != null ? json["error"] : null,
        msg: json["msg"] != null ? json["msg"] : null);
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
