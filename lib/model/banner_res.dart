// To parse this JSON data, do
//
//     final bannerRes = bannerResFromJson(jsonString);

import 'dart:convert';

BannerRes bannerResFromJson(String str) => BannerRes.fromJson(json.decode(str));

String bannerResToJson(BannerRes data) => json.encode(data.toJson());

class BannerRes {
    String? message;
    String? data;

    BannerRes({
        this.message,
        this.data,
    });

    factory BannerRes.fromJson(Map<String, dynamic> json) => BannerRes(
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
    };
}
