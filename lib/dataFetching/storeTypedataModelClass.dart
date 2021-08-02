// To parse this JSON data, do
//
//     final storeTypeDataModelClass = storeTypeDataModelClassFromJson(jsonString);

import 'dart:convert';

StoreTypeDataModelClass storeTypeDataModelClassFromJson(String str) => StoreTypeDataModelClass.fromJson(json.decode(str));

String storeTypeDataModelClassToJson(StoreTypeDataModelClass data) => json.encode(data.toJson());

class StoreTypeDataModelClass {
    StoreTypeDataModelClass({
        this.data,
    });

    List<Datum> data;

    factory StoreTypeDataModelClass.fromJson(Map<String, dynamic> json) => StoreTypeDataModelClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.storetype,
    });

    String storetype;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        storetype: json["storetype"],
    );

    Map<String, dynamic> toJson() => {
        "storetype": storetype,
    };
}
