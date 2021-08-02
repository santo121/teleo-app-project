// To parse this JSON data, do
//
//     final addedSubCategoryModelClass = addedSubCategoryModelClassFromJson(jsonString);

import 'dart:convert';

AddedSubCategoryModelClass addedSubCategoryModelClassFromJson(String str) => AddedSubCategoryModelClass.fromJson(json.decode(str));

String addedSubCategoryModelClassToJson(AddedSubCategoryModelClass data) => json.encode(data.toJson());

class AddedSubCategoryModelClass {
    AddedSubCategoryModelClass({
        this.subcategory,
    });

    List<Subcategory> subcategory;

    factory AddedSubCategoryModelClass.fromJson(Map<String, dynamic> json) => AddedSubCategoryModelClass(
        subcategory: List<Subcategory>.from(json["subcategory"].map((x) => Subcategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subcategory": List<dynamic>.from(subcategory.map((x) => x.toJson())),
    };
}

class Subcategory {
    Subcategory({
        this.subcategory,
    });

    String subcategory;

    factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        subcategory: json["subcategory"] == null ? null : json["subcategory"],
    );

    Map<String, dynamic> toJson() => {
        "subcategory": subcategory == null ? null : subcategory,
    };
}
