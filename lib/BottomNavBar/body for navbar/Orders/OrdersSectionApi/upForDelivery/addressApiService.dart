import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Orders/OrdersSectionApi/upForDelivery/addressModelClass.dart';

class AddressApiService {
  Future<AddressModelClass> getAddress(
      AddressApiServiceRequest req, BuildContext context) async {
    DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
      final String uri =
          "https://teleoappapi.com/api/orders/vendor/getorders/details/${req.orderId}";
      final responce = await http.get(Uri.parse(uri), headers: req.toHeader());
      if (responce.statusCode == 200||responce.statusCode == 400) {
        final jsonString = responce.body;
        final addressModelClass = addressModelClassFromJson(jsonString);
        print(addressModelClass);
        return addressModelClass;
      } else {
        final body = responce.body;
        final error = addressModelClassFromJson(body);
        return throw showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("error"),
                  content: Text(error.details.toString()),
                ));
      }
    } else {
      return throw showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No InterNet Conection"),
                content: Text("check internet connection"),
              ));
    }
  }
}

class AddressApiServiceRequest {
  String vtoken, id, orderId;
  AddressApiServiceRequest({
    this.orderId,
    this.vtoken,
    this.id,
  });
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": this.vtoken, "id": this.id};
    return head;
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
