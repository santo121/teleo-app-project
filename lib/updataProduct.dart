import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart' as mime;

class UpdataProductServicesWithoutSub {
  Future<dynamic> updateWithoutSub(
      UpdateProductRequestWithoutSub req, BuildContext context,
      {@required String productId}) async {
    final String url =
        "https://teleoappapi.com/api/products/vendor/update/$productId";
    final request = new http.MultipartRequest('POST', Uri.parse(url));
    // filePath != null ??
        // request.files.add(await http.MultipartFile.fromPath("file", filePath,
        //     contentType: mime.MediaType('image', 'jpeg')));
    request.headers.addAll(req.toHeader());
    request.fields["productname"] = req.productname;
    request.fields["category"] = req.category;
    request.fields["mrp"] = req.mrp;
    request.fields["sellingprice"] = req.sellingprice;
    request.fields["quantity"] = req.quantity;
    request.fields["unit"] = req.unit;
    request.fields["desc"] = req.desc;

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("product updated"),
      // ));
      return response.statusCode;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.statusCode.toString()),
      ));
      return response.statusCode;
    }
  }
}

class UpdateProductRequestWithoutSub {
  String productname,
      category,
      mrp,
      sellingprice,
      quantity,
      unit,
      desc,
      vendorToken,
      vendorId;
  UpdateProductRequestWithoutSub({
    this.category,
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
//11111111111111111111111111111111111111111111111111111111111111 Sub Category added 1111111111111111111111111111111

class UpdataProductServices {
  Future<dynamic> update(
      UpdateProductRequest req, BuildContext context,
      {@required String productId}) async {
    final String url =
        "https://teleoappapi.com/api/products/vendor/update/$productId";
    final request = new http.MultipartRequest('POST', Uri.parse(url));
    // filePath != null ?
    //     request.files.add(await http.MultipartFile.fromPath("file", filePath,
    //         // ignore: unnecessary_statements
    //         contentType: mime.MediaType('image', 'jpeg'))):null;
    request.headers.addAll(req.toHeader());
    request.fields["productname"] = req.productname;
    request.fields["category"] = req.category;
    request.fields["mrp"] = req.mrp;
    request.fields["sellingprice"] = req.sellingprice;
    request.fields["quantity"] = req.quantity;
    request.fields["unit"] = req.unit;
    request.fields["desc"] = req.desc;
    request.fields["subcategory"] = req.subCategory;
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product updated"),
      ));
      return response.statusCode;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseString),
      ));
      return response.statusCode;
    }
  }
}

class UpdateProductRequest {
  String productname,
      category,
      mrp,
      sellingprice,
      quantity,
      unit,
      desc,
      vendorToken,
      subCategory,
      vendorId;
  UpdateProductRequest(
      {this.category,
      this.unit,
      this.quantity,
      this.mrp,
      this.desc,
      this.productname,
      this.sellingprice,
      this.subCategory});
  Map<String, String> toJson() {
    Map<String, String> map = {
      "productname": productname.toString(),
      "category": category.toString(),
      "mrp": mrp,
      "sellingprice": sellingprice,
      "quantity": quantity,
      "unit": unit,
      "desc": desc,
      "subcategory": subCategory
    };
    return map;
  }

  Map<String, String> toHeader() {
    Map<String, String> head = {"vtoken": vendorToken, "id": vendorId};
    return head;
  }
}
