import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';

class UpForDeliveryStatusapi {

Future<UpForDeliveryStatusapiresponce>deliveryStatus(UpForDeliveryStatusapirequest req,BuildContext context)async
{
  DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
  final String url ="https://teleoappapi.com/api/orders/vendor/update/order/${req.orderid}";
  final responce = await http.post(Uri.parse(url),body: req.toJson(),headers: req.toHead());
  if (responce.statusCode == 200) {
        return UpForDeliveryStatusapiresponce.fromJson(json.decode(responce.body));
      } else {
        return UpForDeliveryStatusapiresponce.fromJson(json.decode(responce.body));
      }
}else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No InterNet Conection"),
                content: Text("check internet connection"),
              ));
    }

}


}

class UpForDeliveryStatusapirequest {
  String vtoken, id, status, orderid;
  UpForDeliveryStatusapirequest(
      {this.orderid, this.vtoken, this.id, this.status});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {"status": status};
    return json;
  }

  Map<String, String> toHead() {
    Map<String, String> head = {
      "vtoken": vtoken,
      "id": id,
    };
    return head;
  }
}

class UpForDeliveryStatusapiresponce {
  UpForDeliveryStatusapiresponce({
    this.msg,
    this.error,
  });
  String msg;
  String error;

  factory UpForDeliveryStatusapiresponce.fromJson(Map<String, dynamic> json) =>
      UpForDeliveryStatusapiresponce(
          msg: json["msg"] != null ? json["msg"] : null,
          error: json['error'] != null ? json["error"] : null);
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