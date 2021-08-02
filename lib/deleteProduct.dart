import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class DeleteProductService {
  Future<DeleteProductResponse> delete(
      DeleteProductReq req, String productId,BuildContext context) async {
        DataConnectionStatus status = await internetChecker();
        if (status == DataConnectionStatus.connected) {
    String url =
        "https://teleoappapi.com/api/products/vendor/delete/$productId";

    final responses =
        await http.delete(Uri.parse(url), headers: req.toHeadee());
        if(responses.statusCode==200||responses.statusCode==400)
        {
          return DeleteProductResponse.fromJson(json.decode(responses.body));
        }else{return throw Exception(responses.statusCode);}
  }else {showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No InterNet Conection"),
                content: Text("check internet connection"),
              ));}
  }
}

class DeleteProductReq {
  String id, vtoken;
  DeleteProductReq({this.id, this.vtoken});
  Map<String, String> toHeadee() {
    Map<String, String> header = {
      "vtoken": vtoken,
      "id": id,
    };
    return header;
  }
}

class DeleteProductResponse {
  String msg;
  DeleteProductResponse({this.msg});
  factory DeleteProductResponse.fromJson(Map<String, dynamic> json) =>
      DeleteProductResponse(msg: json["msg"] != null ? json["msg"] : null);
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

