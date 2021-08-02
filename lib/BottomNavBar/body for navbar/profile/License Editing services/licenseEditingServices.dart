import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';

class LicenceEditingServices {
  final String uri = "https://teleoappapi.com/api/data/vendor/profile/license";

  Future<LicenceEditingServicesResponce> registerLicence(
      LicenceEditingServicesRequest req, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
      final responce = await http.post(Uri.parse(uri),
          body: req.toJson(), headers: req.toHeader());

      if (responce.statusCode == 200 || responce.statusCode == 400) {
        return LicenceEditingServicesResponce.fromJson(
            json.decode(responce.body));
      } else {
        return LicenceEditingServicesResponce.fromJson(
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

class LicenceEditingServicesRequest {
  String vtoken, id, gstNumber, fssai;
  LicenceEditingServicesRequest(
      {this.fssai, this.gstNumber, this.id, this.vtoken});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"gstnumber": this.gstNumber, "fssai": fssai};
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> header = {"vtoken": this.vtoken, "id": this.id};
    return header;
  }
}

class LicenceEditingServicesResponce {
  LicenceEditingServicesResponce({
    this.msg,
    this.error,
  });
  String msg;
  String error;

  factory LicenceEditingServicesResponce.fromJson(Map<String, dynamic> json) =>
      LicenceEditingServicesResponce(
        msg: json["msg"] != null ? json["msg"] : null,
        error: json["error"] != null ? json["error"] : null,
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
