import '../../../../../dataStorage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'FullfiledApiServiceModel.dart';

class FullfiledApiService {
  Future<FullfiledApiServiceModel> fullfiledOreders(
      FullfiledApiServicequest req, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
      final String url = "https://teleoappapi.com/api/orders/vendor/delivered";
      final responce = await http.get(Uri.parse(url), headers: req.toHeader());
      if (responce.statusCode == 200||responce.statusCode == 400) {
        final jsonString = responce.body;
        final fullfiledApiServiceModel =
            fullfiledApiServiceModelFromJson(jsonString);
        return fullfiledApiServiceModel;
      } else {
        final body = responce.body;
        final error = fullfiledApiServiceModelFromJson(body);
        print(error);
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

class FullfiledApiServicequest {
  String vtoken = DataStorage.getVendorToken(), id = DataStorage.getVendorId();
  FullfiledApiServicequest({this.vtoken, this.id});
  Map<String, String> toHeader() {
    Map<String, String> header = {"vtoken": vtoken, "id": id};
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
