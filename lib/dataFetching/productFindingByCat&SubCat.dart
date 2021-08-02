import 'package:http/http.dart'as http;
import 'package:mallu_vendor/dataFetching/ProductFetchingModelClass.dart';
import 'package:mallu_vendor/dataFetching/productFindByCatSubCatModel.dart';
import 'package:mallu_vendor/dataStorage.dart';

class ProductFindingByCatSubCat{

Future<ProductFindByCatSubCatModel> getProduct(ProductFindingByCatSubCatReq req,String category,subCategory)async
{
final String url = "https://teleoappapi.com/api/products/vendor/sort/products/$category/$subCategory";
 
final response = await http.get(Uri.parse(url),headers: req.toHeader());

if(response.statusCode==200||response.statusCode==400)
    {
      final jsonString = response.body;
      final productFetchingModelClass = productFindByCatSubCatModelFromJson(jsonString);
      print(productFetchingModelClass);
      return productFetchingModelClass; 
    }else
    {
      final body = response.body;
      final error = productFindByCatSubCatModelFromJson(body);
      print(error );
      return throw Exception(response.statusCode);
    }

}


}

class  ProductFindingByCatSubCatReq{
  String 
      vendorToken= DataStorage.getVendorToken(),
      vendorId = DataStorage.getVendorId();
  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}