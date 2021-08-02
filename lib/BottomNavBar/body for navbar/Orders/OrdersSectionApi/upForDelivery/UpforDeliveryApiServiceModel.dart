// To parse this JSON data, do
//
//     final upforDeliveryApiServiceModel = upforDeliveryApiServiceModelFromJson(jsonString);

import 'dart:convert';

UpforDeliveryApiServiceModel upforDeliveryApiServiceModelFromJson(String str) => UpforDeliveryApiServiceModel.fromJson(json.decode(str));

String upforDeliveryApiServiceModelToJson(UpforDeliveryApiServiceModel data) => json.encode(data.toJson());

class UpforDeliveryApiServiceModel {
    UpforDeliveryApiServiceModel({
        this.data,
    });

    List<Datum> data;

    factory UpforDeliveryApiServiceModel.fromJson(Map<String, dynamic> json) => UpforDeliveryApiServiceModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.orderid,
        this.name,
        this.count,
        this.total,
        this.orderstatus,
        this.orderpickup,
    });

    String orderid;
    String name;
    String count;
    String total;
    String orderstatus;
    String orderpickup;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderid: json["orderid"],
        name: json["name"],
        count: json["count"],
        total: json["total"],
        orderstatus: json["orderstatus"],
        orderpickup: json["orderpickup"],
    );

    Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "name": name,
        "count": count,
        "total": total,
        "orderstatus": orderstatus,
        "orderpickup": orderpickup,
    };
}
