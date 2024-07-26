// To parse this JSON data, do
//
//     final commentget = commentgetFromJson(jsonString);

import 'dart:convert';

List<Commentget> commentgetFromJson(String str) => List<Commentget>.from(json.decode(str).map((x) => Commentget.fromJson(x)));

String commentgetToJson(List<Commentget> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commentget {
    int id;
    String user;
    int userId;
    int tourId;
    String tourName;
    int rating;
    String comment;
    DateTime createdAt;

    Commentget({
        required this.id,
        required this.user,
        required this.userId,
        required this.tourId,
        required this.tourName,
        required this.rating,
        required this.comment,
        required this.createdAt,
    });

    factory Commentget.fromJson(Map<String, dynamic> json) => Commentget(
        id: json["id"],
        user: json["user"],
        userId: json["user_id"],
        tourId: json["tour_id"],
        tourName: json["tour_name"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "user_id": userId,
        "tour_id": tourId,
        "tour_name": tourName,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
    };
}
