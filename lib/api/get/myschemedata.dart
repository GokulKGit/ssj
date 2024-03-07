// To parse this JSON data, do
//
//     final mySchemeData = mySchemeDataFromJson(jsonString);

import 'dart:convert';

MySchemeData mySchemeDataFromJson(String str) =>
    MySchemeData.fromJson(json.decode(str));

String mySchemeDataToJson(MySchemeData data) => json.encode(data.toJson());

class MySchemeData {
  int status;
  List<JointScheme> jointSchemes;
  String message;

  MySchemeData({
    required this.status,
    required this.jointSchemes,
    required this.message,
  });

  factory MySchemeData.fromJson(Map<String, dynamic> json) => MySchemeData(
        status: json["status"],
        jointSchemes: List<JointScheme>.from(
          json["joint_schemes"].map(
            (x) => JointScheme.fromJson(
              x,
            ),
          ),
        ),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "joint_schemes":
            List<dynamic>.from(jointSchemes.map((x) => x.toJson())),
        "message": message,
      };
}

class JointScheme {
  int id;
  int masterId;
  String schemeTitle;
  String startDate;
  String endDate;
  String schemeAmount;
  String status;

  JointScheme({
    required this.id,
    required this.masterId,
    required this.schemeTitle,
    required this.startDate,
    required this.endDate,
    required this.schemeAmount,
    required this.status,
  });

  factory JointScheme.fromJson(Map<String, dynamic> json) => JointScheme(
        id: json["id"],
        masterId: json["master_id"],
        schemeTitle: json["scheme_title"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        schemeAmount: json["scheme_amount"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "master_id": masterId,
        "scheme_title": schemeTitle,
        "start_date": startDate,
        "end_date": endDate,
        "scheme_amount": schemeAmount,
        "status": status,
      };
}
