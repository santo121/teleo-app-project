import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

class OrderAcceptingApi {
  Future<OrderAcceptingresponce> orderStatus(
      OrderAcceptingrequest req, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();

    if (status == DataConnectionStatus.connected) {
      final String url =
          "https://teleoappapi.com/api/orders/vendor/getorders/items/confirm/${req.orderId}";
      final response = await http.post(Uri.parse(url),
          headers: req.toHeader(), body: req.toJson());
      if (response.statusCode == 200) {
        return OrderAcceptingresponce.fromJson(json.decode(response.body));
      } else {
        throw Exception(response.statusCode);
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

class OrderAcceptingrequest {
  String status, id, vtoken, orderId;
  OrderAcceptingrequest({
    this.status,
    this.id,
    this.orderId,
    this.vtoken,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"status": status};
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vtoken, "id": id};
    return head;
  }
}

class OrderAcceptingresponce {
  String msg;

  String error;
  OrderAcceptingresponce({this.msg, this.error});
  factory OrderAcceptingresponce.fromJson(Map<String, dynamic> json) {
    return OrderAcceptingresponce(
        msg: json["msg"], error: json["error"] != null ? json["error"] : null);
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
