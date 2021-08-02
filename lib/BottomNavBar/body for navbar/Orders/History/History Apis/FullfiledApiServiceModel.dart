// To parse this JSON data, do
//
//     final fullfiledApiServiceModel = fullfiledApiServiceModelFromJson(jsonString);

import 'dart:convert';

FullfiledApiServiceModel fullfiledApiServiceModelFromJson(String str) => FullfiledApiServiceModel.fromJson(json.decode(str));

String fullfiledApiServiceModelToJson(FullfiledApiServiceModel data) => json.encode(data.toJson());

class FullfiledApiServiceModel {
    FullfiledApiServiceModel({
        this.data,
    });

    List<Datum> data;

    factory FullfiledApiServiceModel.fromJson(Map<String, dynamic> json) => FullfiledApiServiceModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.orderid,
        this.total,
        this.name,
        this.userid,
        this.phonenumber,
    });

    String orderid;
    String total;
    String name;
    String userid;
    String phonenumber;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderid: json["orderid"],
        total: json["total"],
        name: json["name"],
        userid: json["userid"],
        phonenumber: json["phonenumber"],
    );

    Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "total": total,
        "name": name,
        "userid": userid,
        "phonenumber": phonenumber,
    };
}
