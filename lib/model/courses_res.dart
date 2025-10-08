// To parse this JSON data, do
//
//     final coursesRes = coursesResFromJson(jsonString);

import 'dart:convert';

CoursesRes coursesResFromJson(String str) => CoursesRes.fromJson(json.decode(str));

String coursesResToJson(CoursesRes data) => json.encode(data.toJson());

class CoursesRes {
    String? message;
    List<Datum>? data;

    CoursesRes({
        this.message,
        this.data,
    });

    factory CoursesRes.fromJson(Map<String, dynamic> json) => CoursesRes(
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
    String? author;
    String? duration;
    String? price;
    String? originalPrice;
    double? rating;
    int? reviews;
    String? tag;
    String? image;

    Datum({
        this.title,
        this.author,
        this.duration,
        this.price,
        this.originalPrice,
        this.rating,
        this.reviews,
        this.tag,
        this.image,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        author: json["author"],
        duration: json["duration"],
        price: json["price"],
        originalPrice: json["originalPrice"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"],
        tag: json["tag"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "duration": duration,
        "price": price,
        "originalPrice": originalPrice,
        "rating": rating,
        "reviews": reviews,
        "tag": tag,
        "image": image,
    };
}
