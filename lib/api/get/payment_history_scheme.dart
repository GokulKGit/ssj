// To parse this JSON data, do
//
//     final paymentHistoryOfScheme = paymentHistoryOfSchemeFromJson(jsonString);

import 'dart:convert';

PaymentHistoryOfScheme paymentHistoryOfSchemeFromJson(String str) =>
    PaymentHistoryOfScheme.fromJson(json.decode(str));

String paymentHistoryOfSchemeToJson(PaymentHistoryOfScheme data) =>
    json.encode(data.toJson());

class PaymentHistoryOfScheme {
  int status;
  List<Payment> payments;
  String message;

  PaymentHistoryOfScheme({
    required this.status,
    required this.payments,
    required this.message,
  });

  factory PaymentHistoryOfScheme.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryOfScheme(
        status: json["status"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
        "message": message,
      };
}

class Payment {
  int id;
  String goldGram = "";
  String schemeAmount = "";
  String schemeTitle = "";
  String paymentDate = "";
  String paymentMode = "";
  String goldrate = "";

  Payment({
    required this.id,
    required this.goldGram,
    required this.schemeAmount,
    required this.schemeTitle,
    required this.paymentDate,
    required this.paymentMode,
    required this.goldrate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        goldGram: json["gold_gram"] ?? "",
        schemeAmount: json["scheme_amount"] ?? "",
        schemeTitle: json["scheme_title"] ?? "",
        paymentDate: json["payment_date"] != null ? json["payment_date"] : "",
        paymentMode: json["payment_mode"] ?? "",
        goldrate: json["goldrate"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gold_gram": goldGram,
        "scheme_amount": schemeAmount,
        "scheme_title": schemeTitle,
        "payment_date": paymentDate,
        "payment_mode": paymentMode,
        "goldrate": goldrate,
      };
}
