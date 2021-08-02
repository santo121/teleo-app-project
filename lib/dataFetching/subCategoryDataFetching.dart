


import 'package:http/http.dart'as http;
import 'package:mallu_vendor/dataFetching/subCategoryModelClass.dart';
import 'package:mallu_vendor/dataStorage.dart';

class SubCategoryDataFetching{

Future<SubCategoryModelClass> getStoreType(SubCategoryTypeDataModelClassReq reqs,)async
{

  final url ="https://teleoappapi.com/api/products/vendor/fetch/subcategory/${reqs.category}";
  final req = await http.get(Uri.parse(url),headers: reqs.toHeader(),);
    if(req.statusCode==200)
    {
      final jsonString = req.body;
      final subCategoryModelClass = subCategoryModelClassFromJson(jsonString);
      print(subCategoryModelClass);
      return subCategoryModelClass; 
    }else
    {
      final body = req.body;
      final error = subCategoryModelClassFromJson(body);
      print(error );
    }
  
}

}
class  SubCategoryTypeDataModelClassReq{
  String 
      vendorToken= DataStorage.getVendorToken(),
      vendorId = DataStorage.getVendorId();
      String category;
    SubCategoryTypeDataModelClassReq({this.vendorId,this.vendorToken,this.category});
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}