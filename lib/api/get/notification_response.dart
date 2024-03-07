// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  List<Notification> notifications;

  NotificationResponse({
    required this.notifications,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class Notification {
  int id;
  String title;
  String body;

  Notification({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
