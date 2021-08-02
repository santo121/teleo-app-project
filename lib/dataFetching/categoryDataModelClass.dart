// To parse this JSON data, do
//
//     final categoryDataModelClass = categoryDataModelClassFromJson(jsonString);

import 'dart:convert';

CategoryDataModelClass categoryDataModelClassFromJson(String str) => CategoryDataModelClass.fromJson(json.decode(str));

String categoryDataModelClassToJson(CategoryDataModelClass data) => json.encode(data.toJson());

class CategoryDataModelClass {
    CategoryDataModelClass({
        this.data,
    });

    List<Datum> data;

    factory CategoryDataModelClass.fromJson(Map<String, dynamic> json) => CategoryDataModelClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.category,
    });

    String category;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
    };
}
