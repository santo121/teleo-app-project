// To parse this JSON data, do
//
//     final getOrderModelClass = getOrderModelClassFromJson(jsonString);

import 'dart:convert';

GetOrderModelClass getOrderModelClassFromJson(String str) => GetOrderModelClass.fromJson(json.decode(str));

String getOrderModelClassToJson(GetOrderModelClass data) => json.encode(data.toJson());

class GetOrderModelClass {
    GetOrderModelClass({
        this.data,
    });

    List<Datum> data;

    factory GetOrderModelClass.fromJson(Map<String, dynamic> json) => GetOrderModelClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.count,
        this.total,
        this.orderstatus,
        this.orderid,
        this.userid,
        this.name,
    });

    String count;
    String total;
    String orderstatus;
    String orderid;
    String userid;
    String name;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        count: json["count"],
        total: json["total"],
        orderstatus: json["orderstatus"],
        orderid: json["orderid"],
        userid: json["userid"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "total": total,
        "orderstatus": orderstatus,
        "orderid": orderid,
        "userid": userid,
        "name": name,
    };
}
