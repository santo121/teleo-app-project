import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart' as mime;

class ProductService {

  Future<ProductServicerespoce>productServices(ProductServicerequest req ,BuildContext context)async
  { DataConnectionStatus status = await internetChecker();
    if(status == DataConnectionStatus.connected){
    String url = "https://teleoappapi.com/api/products/vendor/addproduct";
    final response = await http.post(Uri.parse(url),body:req.toJson(),headers: req.toHeader());
    if(response.statusCode==200)
    {
      return ProductServicerespoce.fromJson(json.decode(response.body));
    }else{
      throw Exception(response.statusCode);
    }
    }else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No InterNet Conection"),
                content: Text("check internet connection"),
              ));
    }
  }
}


//111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111


class MultyPartProductServices
{

  String url = "https://teleoappapi.com/api/products/vendor/addproduct";
  

  Future<dynamic> multypart(ProductServicerequest req,filePath)async
  {
    final request = new http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("file",  filePath,contentType: mime.MediaType('image','jpeg')));
    request.headers.addAll(req.toHeader());
    request.fields["productname"]=req.productname;
    request.fields["category"]=req.category;
    request.fields["mrp"]=req.mrp;
    request.fields["sellingprice"]=req.sellingprice;
    request.fields["quantity"]=req.quantity;
    request.fields["unit"]=req.unit;
    request.fields["desc"]=req.desc;
    
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print("2222222222222222222222222222222222222222 s $responseString");

    if(response.statusCode==200){
      return response.statusCode;

    }else{
      return response.statusCode;
    }  
  }
}




class MultyPartProductService
{

  String url = "https://teleoappapi.com/api/products/vendor/addproduct";
  

  Future<dynamic> multypart(ProductServicerequests req,filePath)async
  {
    final request = new http.MultipartRequest('POST', Uri.parse(url),);
    request.files.add(await http.MultipartFile.fromPath("file",  filePath,contentType: mime.MediaType('image','jpeg')));
    request.headers.addAll(req.toHeader());
    // request.fields.addAll(req.toJson());
    request.fields["productname"]=req.productname;
    request.fields["category"]=req.category;
    request.fields["mrp"]=req.mrp;
    request.fields["sellingprice"]=req.sellingprice;
    request.fields["quantity"]=req.quantity;
    request.fields["unit"]=req.unit;
    request.fields["desc"]=req.desc;
    request.fields["subcategory"]=req.subCategoty;
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print("2222222222222222222222222222222222222222 s $responseString");

    if(response.statusCode==200){
      return response.statusCode;

    }else{
      return response.statusCode;
    }  
  }
}

//111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111





class ProductServicerespoce {
  String msg, error;
  ProductServicerespoce({this.error, this.msg});
  factory ProductServicerespoce.fromJson(Map<String, dynamic> json) {
    return ProductServicerespoce(
      error: json["error"] != null ? json["error"] : null,
      msg: json["msg"] !=null ? json["msg"]:null
    );
  }
}

class ProductServicerequest {
  String productname,
      category,
      mrp,
      sellingprice,
      quantity,
      unit,
      desc,
      vendorToken,
      vendorId;
  ProductServicerequest(
      {this.category,
      this.unit,
      this.quantity,
      this.mrp,
      this.desc,
      this.productname,
      this.sellingprice,
      
      });
  Map<String, String> toJson() {
    Map<String, String> map = {
      "productname": productname.toString(),
      "category": category.toString(),
      "mrp": mrp,
      "sellingprice": sellingprice,
      "quantity": quantity,
      "unit": unit,
      "desc": desc,
    };
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}

class ProductServicerequests {
  String productname,
      category,
      mrp,
      sellingprice,
      quantity,
      unit,
      desc,
      subCategoty,
      vendorToken,
      vendorId;
  ProductServicerequests(
      {this.category,
      this.unit,
      this.quantity,
      this.mrp,
      this.desc,
      this.productname,
      this.sellingprice,
      this.subCategoty
      });
  Map<String, String> toJson() {
    Map<String, String> map = {
      "productname": productname.toString(),
      "category": category.toString(),
      "mrp": mrp,
      "sellingprice": sellingprice,
      "quantity": quantity,
      "unit": unit,
      "desc": desc,
      "subcategory": subCategoty,
      
    };
    return map;
  }

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