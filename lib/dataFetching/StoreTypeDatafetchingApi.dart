

import 'package:http/http.dart'as http;
import 'package:mallu_vendor/dataStorage.dart';

import 'storeTypedataModelClass.dart';
class StoretypeDataFetching{

Future<StoreTypeDataModelClass> getStoreType(StoreTypeDataModelClassReq reqs)async
{

  final url ="https://teleoappapi.com/api/products/vendor/fetch/storetype";
  final req = await http.get(Uri.parse(url),headers: reqs.toHeader());
    if(req.statusCode==200)
    {
      final jsonString = req.body;
      final storeTypeDataModelClass = storeTypeDataModelClassFromJson(jsonString);
      print(storeTypeDataModelClass);
      return storeTypeDataModelClass; 
    }else
    {
      final body = req.body;
      final error = storeTypeDataModelClassFromJson(body);
      print(error );
      return throw Exception(req.statusCode);
    }
  
}

}
class  StoreTypeDataModelClassReq{
  String 
      vendorToken= DataStorage.getVendorToken(),
      vendorId = DataStorage.getVendorId();
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}