// To parse this JSON data, do
//
//     final myCustomerModelClass = myCustomerModelClassFromJson(jsonString);

import 'dart:convert';

MyCustomerModelClass myCustomerModelClassFromJson(String str) => MyCustomerModelClass.fromJson(json.decode(str));

String myCustomerModelClassToJson(MyCustomerModelClass data) => json.encode(data.toJson());

class MyCustomerModelClass {
    MyCustomerModelClass({
        this.data,
    });

    List<Datum> data;

    factory MyCustomerModelClass.fromJson(Map<String, dynamic> json) => MyCustomerModelClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.name,
        this.phonenumber,
    });

    String name;
    String phonenumber;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        phonenumber: json["phonenumber"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phonenumber": phonenumber,
    };
}
