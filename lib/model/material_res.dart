// To parse this JSON data, do
//
//     final materialRes = materialResFromJson(jsonString);

import 'dart:convert';

MaterialRes materialResFromJson(String str) => MaterialRes.fromJson(json.decode(str));

String materialResToJson(MaterialRes data) => json.encode(data.toJson());

class MaterialRes {
    String? message;
    List<Datum>? data;

    MaterialRes({
        this.message,
        this.data,
    });

    factory MaterialRes.fromJson(Map<String, dynamic> json) => MaterialRes(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? title;
    String? brand;
    String? price;
    String? originalPrice;
    double? rating;
    int? reviews;
    String? tag;
    String? image;
     String? time;
    Datum({
        this.title,
        this.brand,
        this.price,
        this.originalPrice,
        this.rating,
        this.reviews,
        this.tag,
        this.image,
        this.time,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        brand: json["brand"],
        price: json["price"],
        originalPrice: json["originalPrice"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"],
        tag: json["tag"],
        image: json["image"],
        time: json["time"] ?? '1 day ago',
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "brand": brand,
        "price": price,
        "originalPrice": originalPrice,
        "rating": rating,
        "reviews": reviews,
        "tag": tag,
        "image": image,
        "time": time,
    };
}
