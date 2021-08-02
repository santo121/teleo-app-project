import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:convert';

class HomePageStoreStatusApiService {
  Future<HomePageStoreStatusApiServiceResponce> storeStatusService(
      HomePageStoreStatusApiServiceRequest req, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
      final String url = "https://teleoappapi.com/api/data/vendor/storestatus";
      final responce = await http.post(Uri.parse(url),
          body: req.toJson(), headers: req.toHeader());
      if (responce.statusCode == 200) {
        return HomePageStoreStatusApiServiceResponce.fromJson(
            json.decode(responce.body));
      } else {
        return HomePageStoreStatusApiServiceResponce.fromJson(
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

class HomePageStoreStatusApiServiceRequest {
  String vtoken, id,status;
  
  HomePageStoreStatusApiServiceRequest({this.vtoken, this.id, this.status});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"status": status};
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vtoken, "id": id};
    return head;
  }
}

class HomePageStoreStatusApiServiceResponce {
  String msg;
  HomePageStoreStatusApiServiceResponce({this.msg});
  factory HomePageStoreStatusApiServiceResponce.fromJson(
          Map<String, dynamic> json) =>
      HomePageStoreStatusApiServiceResponce(
        msg: json["msg"] != null ? json["msg"] : null,
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
