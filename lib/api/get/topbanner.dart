// To parse this JSON data, do
//
//     final topBanner = topBannerFromJson(jsonString);

import 'dart:convert';

TopBanner topBannerFromJson(String str) => TopBanner.fromJson(json.decode(str));

String topBannerToJson(TopBanner data) => json.encode(data.toJson());

class TopBanner {
  String message;
  List<Datum> data;

  TopBanner({
    required this.message,
    required this.data,
  });

  factory TopBanner.fromJson(Map<String, dynamic> json) => TopBanner(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String bannertitle;
  String bannerimageUrl;

  Datum({
    required this.id,
    required this.bannertitle,
    required this.bannerimageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        bannertitle: json["bannertitle"],
        bannerimageUrl: json["bannerimage_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bannertitle": bannertitle,
        "bannerimage_url": bannerimageUrl,
      };
}
