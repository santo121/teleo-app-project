// To parse this JSON data, do
//
//     final addedCategoryModelClass = addedCategoryModelClassFromJson(jsonString);

import 'dart:convert';

AddedCategoryModelClass addedCategoryModelClassFromJson(String str) => AddedCategoryModelClass.fromJson(json.decode(str));

String addedCategoryModelClassToJson(AddedCategoryModelClass data) => json.encode(data.toJson());

class AddedCategoryModelClass {
    AddedCategoryModelClass({
        this.category,
    });

    List<Category> category;

    factory AddedCategoryModelClass.fromJson(Map<String, dynamic> json) => AddedCategoryModelClass(
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.category,
    });

    String category;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
    };
}
