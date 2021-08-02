import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:mallu_vendor/dataFetching/addedCategorysModelClass.dart';
import 'package:mallu_vendor/dataStorage.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

// import 'storeTypedataModelClass.dart';
class AddCategorysFetchingApi{

Future<AddedCategoryModelClass> getAddedCategory(AddedCategoryTypeDataModelClassReq reqs,BuildContext context)async
{DataConnectionStatus status = await internetChecker();
    if (status == DataConnectionStatus.connected) {

  final url ="https://teleoappapi.com/api/products/vendor/fetch/vendor/category";
  final req = await http.get(Uri.parse(url),headers: reqs.toHeader());
    if(req.statusCode==200)
    {
      final jsonString = req.body;
      final categoryDataModelClass = addedCategoryModelClassFromJson(jsonString);
      print(categoryDataModelClass);
      return categoryDataModelClass; 
    }else
    {
      final body = req.body;
      final error = addedCategoryModelClassFromJson(body);
      print(error );
    }
    }else
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
class  AddedCategoryTypeDataModelClassReq{
  String 
      vendorToken= DataStorage.getVendorToken(),
      vendorId = DataStorage.getVendorId();
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
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