// To parse this JSON data, do
//
//     final addressModelClass = addressModelClassFromJson(jsonString);

import 'dart:convert';

AddressModelClass addressModelClassFromJson(String str) => AddressModelClass.fromJson(json.decode(str));

String addressModelClassToJson(AddressModelClass data) => json.encode(data.toJson());

class AddressModelClass {
    AddressModelClass({
        this.details,
    });

    Details details;

    factory AddressModelClass.fromJson(Map<String, dynamic> json) => AddressModelClass(
        details: Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "details": details.toJson(),
    };
}

class Details {
    Details({
        this.address,
        this.houseno,
    });

    String address;
    String houseno;

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        address: json["address"],
        houseno: json["houseno"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "houseno": houseno,
    };
}
