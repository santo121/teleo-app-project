// To parse this JSON data, do
//
//     final fetchingpersonalInfoModelClass = fetchingpersonalInfoModelClassFromJson(jsonString);

import 'dart:convert';

FetchingpersonalInfoModelClass fetchingpersonalInfoModelClassFromJson(String str) => FetchingpersonalInfoModelClass.fromJson(json.decode(str));

String fetchingpersonalInfoModelClassToJson(FetchingpersonalInfoModelClass data) => json.encode(data.toJson());

class FetchingpersonalInfoModelClass {
    FetchingpersonalInfoModelClass({
        this.data,
    });

    Data data;

    factory FetchingpersonalInfoModelClass.fromJson(Map<String, dynamic> json) => FetchingpersonalInfoModelClass(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.ownername,
        this.storename,
        this.storetype,
        this.phonenumber,
        this.alternatenumber,
        this.email,
        this.address,
        this.city,
        this.state,
        this.postalcode,
        this.country,
        this.gstnumber,
        this.fssai,
        this.imagename,
        this.hash,
        this.piclocation,
    });

    String id;
    String ownername;
    String storename;
    String storetype;
    String phonenumber;
    String alternatenumber;
    String email;
    String address;
    String city;
    String state;
    String postalcode;
    String country;
    String gstnumber;
    String fssai;
    String imagename;
    String hash;
    String piclocation;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        ownername: json["ownername"],
        storename: json["storename"],
        storetype: json["storetype"],
        phonenumber: json["phonenumber"],
        alternatenumber: json["alternatenumber"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        postalcode: json["postalcode"],
        country: json["country"],
        gstnumber: json["gstnumber"],
        fssai: json["fssai"],
        imagename: json["imagename"],
        hash: json["hash"],
        piclocation: json["piclocation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ownername": ownername,
        "storename": storename,
        "storetype": storetype,
        "phonenumber": phonenumber,
        "alternatenumber": alternatenumber,
        "email": email,
        "address": address,
        "city": city,
        "state": state,
        "postalcode": postalcode,
        "country": country,
        "gstnumber": gstnumber,
        "fssai": fssai,
        "imagename": imagename,
        "hash": hash,
        "piclocation": piclocation,
    };
}
