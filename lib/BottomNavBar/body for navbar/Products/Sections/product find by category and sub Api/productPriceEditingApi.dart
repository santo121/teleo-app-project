import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';

class ProductPriceEditingApi {
  Future<ProductPriceEditingApiresponce> editProductPrice(
      ProductPriceEditingApirequest req, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
      final String url =
          "https://teleoappapi.com/api/products/vendor/update/price/${req.productId}";
      final responce = await http.post(Uri.parse(url),
          headers: req.toHeader(), body: req.toJson());
      if (responce.statusCode == 200) {
        return ProductPriceEditingApiresponce.fromJson(
            json.decode(responce.body));
      } else {
        return ProductPriceEditingApiresponce.fromJson(
            json.decode(responce.body));
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

class ProductPriceEditingApirequest {
  String vtoken, id, price, productId;
  ProductPriceEditingApirequest(
      {this.vtoken, this.id, this.price, this.productId});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"price": price};
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> head = {
      "vtoken": vtoken,
      "id": id,
    };
    return head;
  }
}

class ProductPriceEditingApiresponce {
  ProductPriceEditingApiresponce({
    this.msg,
    this.data,
  });
  String msg;
  String data;
  factory ProductPriceEditingApiresponce.fromJson(Map<String, dynamic> json) =>
      ProductPriceEditingApiresponce(
        msg: json["msg"] != null ? json["msg"] : null,
        data: json["data"] != null ? json["data"] : null,
      );
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
