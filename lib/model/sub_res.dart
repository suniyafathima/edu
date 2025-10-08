// To parse this JSON data, do
//
//     final subjectres = subjectresFromJson(jsonString);

import 'dart:convert';

Subjectres subjectresFromJson(String str) => Subjectres.fromJson(json.decode(str));

String subjectresToJson(Subjectres data) => json.encode(data.toJson());

class Subjectres {
    String? message;
    List<Datum>? data;

    Subjectres({
        this.message,
        this.data,
    });

    factory Subjectres.fromJson(Map<String, dynamic> json) => Subjectres(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? subject;
    String? icon;
    String? mainColor;
    String? gradientColor;

    Datum({
        this.subject,
        this.icon,
        this.mainColor,
        this.gradientColor,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subject: json["subject"],
        icon: json["icon"],
        mainColor: json["main-color"],
        gradientColor: json["gradient-color"],
    );

    Map<String, dynamic> toJson() => {
        "subject": subject,
        "icon": icon,
        "main-color": mainColor,
        "gradient-color": gradientColor,
    };
}
