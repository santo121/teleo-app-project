import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetShopTypeService {
  static const String url =
      'https://teleoappapi.com/api/products/vendor/fetch/storetype';
  static Future<List<GetShopType>> getShoptype(GetShopTypeRequest req) async {
   final response = await http.get(Uri.parse(url),headers: req.toHeader());
   final body =json.decode(response.body);
   return body.map<GetShopType>(GetShopType.fromJson).toList();
   
   
   
   
   
   
   
   
   
   
    // try {
    //   final response = await http.get(
    //       Uri.parse(
    //         url,
    //       ),
    //       headers: req.toHeader());
    //   if (200 == response.statusCode) {
    //     return GetShopType.fromJson(json.decode(response.body));
    //   } else {
    //     return throw Exception(response.statusCode);
    //   }
    // } catch (e) {
    //   return throw Exception(e);
    // }
  }
}
//2222222222222222222222222222222222222

class GetShopTypeRequest {
  String id, vToken;
  GetShopTypeRequest({this.id, this.vToken});
  Map<String, String> toHeader() {
    Map<String, String> header = {"vtoken": vToken, "id": id};
    return header;
  }
}

class GetShopType {
  GetShopType({
    this.data,
  });

  final Data data;
  static GetShopType fromJson(json) => GetShopType(
      data: Data.fromJson(json["data"]),
  );
  // factory GetShopType.fromJson(Map<String, dynamic> json) => GetShopType(
  //       data: Data.fromJson(json["data"]),
  //     );
}

class Data {
  final String storetype;
  Data({
    this.storetype,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        storetype: json["storetype"],
      );
  Map<String, dynamic> toJson() => {
        "storetype": storetype,
      };
}

//2222222222222222222222222222222222222

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
