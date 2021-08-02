// To parse this JSON data, do
//
//     final productFetchingModelClass = productFetchingModelClassFromJson(jsonString);

import 'dart:convert';

ProductFetchingModelClass productFetchingModelClassFromJson(String str) => ProductFetchingModelClass.fromJson(json.decode(str));

String productFetchingModelClassToJson(ProductFetchingModelClass data) => json.encode(data.toJson());

class ProductFetchingModelClass {
    ProductFetchingModelClass({
        this.data,
    });

    List<Datum> data;

    factory ProductFetchingModelClass.fromJson(Map<String, dynamic> json) => ProductFetchingModelClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.storeid,
        this.productid,
        this.productname,
        this.category,
        this.subcategory,
        this.mrp,
        this.sellingprice,
        this.quantity,
        this.unit,
        this.description,
        this.imagelocation,
    });

    String storeid;
    String productid;
    String productname;
    String category;
    String subcategory;
    String mrp;
    String sellingprice;
    int quantity;
    String unit;
    String description;
    String imagelocation;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        storeid: json["storeid"],
        productid: json["productid"],
        productname: json["productname"],
        category: json["category"],
        subcategory: json["subcategory"],
        mrp: json["mrp"],
        sellingprice: json["sellingprice"],
        quantity: json["quantity"],
        unit: json["unit"],
        description: json["description"],
        imagelocation: json["imagelocation"],
    );

    Map<String, dynamic> toJson() => {
        "storeid": storeid,
        "productid": productid,
        "productname": productname,
        "category": category,
        "subcategory": subcategory,
        "mrp": mrp,
        "sellingprice": sellingprice,
        "quantity": quantity,
        "unit": unit,
        "description": description,
        "imagelocation": imagelocation,
    };
}
