import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/profile/fetchingpersonalInfoModelClass.dart';
import 'package:http/http.dart'as http;

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mallu_vendor/dataStorage.dart';
import '../../../dataStorage.dart';
class FetchingPersonalInfoApi{

  Future<FetchingpersonalInfoModelClass> register(FetchingPersonalInfoApiReq req,BuildContext context)async
  {

   final String url = "https://teleoappapi.com/api/data/vendor/data/profile";
   final response = await http.get(Uri.parse(url),headers:req.toHeader());
   DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {
    if(response.statusCode==200)
    {
      final jsonString = response.body;
      final categoryDataModelClass = fetchingpersonalInfoModelClassFromJson(jsonString);
      print(categoryDataModelClass);
      return categoryDataModelClass;
    }else{
      final body = response.body;
      final error = fetchingpersonalInfoModelClassFromJson(body);
      print(error );
    }}else
    {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No InterNet Conection"),
                content: Text("check internet connection"),
              ));
    }

 
  }
}
class FetchingPersonalInfoApiReq{ 
  String vendorToken= DataStorage.getVendorToken(),
      vendorId = DataStorage.getVendorId();
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }}

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