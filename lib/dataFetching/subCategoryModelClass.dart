// To parse this JSON data, do
//
//     final subCategoryModelClass = subCategoryModelClassFromJson(jsonString);

import 'dart:convert';

SubCategoryModelClass subCategoryModelClassFromJson(String str) => SubCategoryModelClass.fromJson(json.decode(str));

String subCategoryModelClassToJson(SubCategoryModelClass data) => json.encode(data.toJson());

class SubCategoryModelClass {
    SubCategoryModelClass({
        this.data,
    });

    List<Datum> data;

    factory SubCategoryModelClass.fromJson(Map<String, dynamic> json) => SubCategoryModelClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.subcategory,
    });

    String subcategory;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subcategory: json["subcategory"],
    );

    Map<String, dynamic> toJson() => {
        "subcategory": subcategory,
    };
}
