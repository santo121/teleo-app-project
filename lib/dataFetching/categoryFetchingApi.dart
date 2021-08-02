import 'package:http/http.dart'as http;
import 'package:mallu_vendor/dataFetching/categoryDataModelClass.dart';
import 'package:mallu_vendor/dataStorage.dart';

import 'storeTypedataModelClass.dart';
class CategorytypeDataFetching{ 

Future<CategoryDataModelClass> getStoreType(CategoryTypeDataModelClassReq reqs)async
{

  final url ="https://teleoappapi.com/api/products/vendor/fetch/category";
  final req = await http.get(Uri.parse(url),headers: reqs.toHeader());
    if(req.statusCode==200)
    {
      final jsonString = req.body;
      final categoryDataModelClass = categoryDataModelClassFromJson(jsonString);
      print(categoryDataModelClass);
      return categoryDataModelClass; 
    }else
    {
      final body = req.body;
      final error = storeTypeDataModelClassFromJson(body);
      print(error );
    }
  
}

}
class  CategoryTypeDataModelClassReq{
  String 
      vendorToken= DataStorage.getVendorToken(),
      vendorId = DataStorage.getVendorId();
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}