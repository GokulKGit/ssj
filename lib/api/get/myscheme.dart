// To parse this JSON data, do
//
//     final showMyScheme = showMySchemeFromJson(jsonString);

import 'dart:convert';

ShowMyScheme showMySchemeFromJson(String str) =>
    ShowMyScheme.fromJson(json.decode(str));

String showMySchemeToJson(ShowMyScheme data) => json.encode(data.toJson());

class ShowMyScheme {
  int status;
  JointScheme jointScheme;
  String message;

  ShowMyScheme({
    required this.status,
    required this.jointScheme,
    required this.message,
  });

  factory ShowMyScheme.fromJson(Map<String, dynamic> json) => ShowMyScheme(
        status: json["status"],
        jointScheme: JointScheme.fromJson(json["joint_scheme"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "joint_scheme": jointScheme.toJson(),
        "message": message,
      };
}

class JointScheme {
  int id;
  int masterId;
  String schemeTitle;
  DateTime startDate;
  DateTime endDate;
  String schemeAmount;

  JointScheme({
    required this.id,
    required this.masterId,
    required this.schemeTitle,
    required this.startDate,
    required this.endDate,
    required this.schemeAmount,
  });

  factory JointScheme.fromJson(Map<String, dynamic> json) => JointScheme(
        id: json["id"],
        masterId: json["master_id"],
        schemeTitle: json["scheme_title"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        schemeAmount: json["scheme_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "master_id": masterId,
        "scheme_title": schemeTitle,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "scheme_amount": schemeAmount,
      };
}
