import 'dart:convert';

GoldSchemes goldSchemesFromJson(String str) =>
    GoldSchemes.fromJson(json.decode(str));

String goldSchemesToJson(GoldSchemes data) => json.encode(data.toJson());

class GoldSchemes {
  String message;
  List<Datum> data;

  GoldSchemes({
    required this.message,
    required this.data,
  });

  factory GoldSchemes.fromJson(Map<String, dynamic> json) => GoldSchemes(
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
  String schemeTitle;
  List<int> schemeAmount;
  String startDate;
  String endDate;
  String tier;
  String agelimit;
  String description;
  String bannerImageUrl;
  String addBenifit;

  Datum({
    required this.id,
    required this.schemeTitle,
    required this.schemeAmount,
    required this.startDate,
    required this.endDate,
    required this.tier,
    required this.agelimit,
    required this.description,
    required this.bannerImageUrl,
    required this.addBenifit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      schemeTitle: json["scheme_title"],
      schemeAmount: List<int>.from(json["scheme_amount"].map((x) => x)),
      startDate: json["start_date"],
      endDate: json["end_date"],
      tier: json["tier"],
      agelimit: json["agelimit"],
      description: json["description"],
      bannerImageUrl: json["banner_image_url"],
      addBenifit: json['addbenifit']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "scheme_title": schemeTitle,
        "scheme_amount": List<dynamic>.from(schemeAmount.map((x) => x)),
        "start_date": startDate,
        "end_date": endDate,
        "tier": tier,
        "agelimit": agelimit,
        "description": description,
        "banner_image_url": bannerImageUrl,
        "addbenifit": addBenifit,
      };
}
