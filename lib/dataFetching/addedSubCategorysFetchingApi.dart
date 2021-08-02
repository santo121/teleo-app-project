import 'package:http/http.dart'as http;
import 'package:mallu_vendor/dataFetching/subCategoryModelClass.dart';
import 'package:mallu_vendor/dataStorage.dart';

import 'addedCategorysModelClass.dart';
import 'addedSubCategoryModelClass.dart';

class AddedSubCategorysFetchingApi{

Future<AddedSubCategoryModelClass> getAddedSubCategory(AddedSubCategoryTypeDataModelClassReq reqs,)async
{

  final url ="https://teleoappapi.com/api/products/vendor/fetch/vendor/subcategory/${reqs.category}";
  final req = await http.get(Uri.parse(url),headers: reqs.toHeader(),);
    if(req.statusCode==200)
    {
      final jsonString = req.body;
      final subCategoryModelClass = addedSubCategoryModelClassFromJson(jsonString);
      print(subCategoryModelClass);
      return subCategoryModelClass; 
    }else
    {
      final body = req.body;
      final error =  addedSubCategoryModelClassFromJson(body);
      print(error );
      
    }
  
}

}
class  AddedSubCategoryTypeDataModelClassReq{
  String 
      vendorToken= DataStorage.getVendorToken(),
      vendorId = DataStorage.getVendorId();
      String category;
    AddedSubCategoryTypeDataModelClassReq({this.vendorId,this.vendorToken,this.category});
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}