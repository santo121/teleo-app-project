// To parse this JSON data, do
//
//     final upforDeliveryitemsModel = upforDeliveryitemsModelFromJson(jsonString);

import 'dart:convert';

UpforDeliveryitemsModel upforDeliveryitemsModelFromJson(String str) => UpforDeliveryitemsModel.fromJson(json.decode(str));

String upforDeliveryitemsModelToJson(UpforDeliveryitemsModel data) => json.encode(data.toJson());

class UpforDeliveryitemsModel {
    UpforDeliveryitemsModel({
        this.data,
        this.sum,
        this.phonenumber,
        this.username,
        this.orderedtime,
        this.status,
        this.delivery,
        this.paymentmethod,
    });

    List<Datum> data;
    int sum;
    String phonenumber;
    String username;
    String orderedtime;
    String status;
    String delivery;
    String paymentmethod;

    factory UpforDeliveryitemsModel.fromJson(Map<String, dynamic> json) => UpforDeliveryitemsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        sum: json["sum"],
        phonenumber: json["phonenumber"],
        username: json["username"],
        orderedtime: json["orderedtime"],
        status: json["status"],
        delivery: json["delivery"],
        paymentmethod: json["paymentmethod"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "sum": sum,
        "phonenumber": phonenumber,
        "username": username,
        "orderedtime": orderedtime,
        "status": status,
        "delivery": delivery,
        "paymentmethod": paymentmethod,
    };
}

class Datum {
    Datum({
        this.productname,
        this.quantity,
        this.unit,
        this.price,
        this.total,
        this.imagelocation,
        this.orderstatus,
        this.orderid,
        this.userid,
        this.username,
    });

    String productname;
    int quantity;
    String unit;
    String price;
    String total;
    String imagelocation;
    String orderstatus;
    String orderid;
    String userid;
    String username;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productname: json["productname"],
        quantity: json["quantity"],
        unit: json["unit"],
        price: json["price"],
        total: json["total"],
        imagelocation: json["imagelocation"],
        orderstatus: json["orderstatus"],
        orderid: json["orderid"],
        userid: json["userid"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "productname": productname,
        "quantity": quantity,
        "unit": unit,
        "price": price,
        "total": total,
        "imagelocation": imagelocation,
        "orderstatus": orderstatus,
        "orderid": orderid,
        "userid": userid,
        "username": username,
    };
}
