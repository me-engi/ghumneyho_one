// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
    int id;
    String title;
    String description;
    String notificationType;
    DateTime createdAt;
    String url;

    NotificationModel({
        required this.id,
        required this.title,
        required this.description,
        required this.notificationType,
        required this.createdAt,
        required this.url,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        notificationType: json["notification_type"],
        createdAt: DateTime.parse(json["created_at"]),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "notification_type": notificationType,
        "created_at": createdAt.toIso8601String(),
        "url": url,
    };
}
