// To parse this JSON data, do
//
//     final dateTimeModel = dateTimeModelFromJson(jsonString);

import 'dart:convert';

DateTimeModel dateTimeModelFromJson(String str) => DateTimeModel.fromJson(json.decode(str));

String dateTimeModelToJson(DateTimeModel data) => json.encode(data.toJson());

class DateTimeModel {
    int id;
    int tour;
    DateTime unavailableDate;

    DateTimeModel({
        required this.id,
        required this.tour,
        required this.unavailableDate,
    });

    factory DateTimeModel.fromJson(Map<String, dynamic> json) => DateTimeModel(
        id: json["id"],
        tour: json["tour"],
        unavailableDate: DateTime.parse(json["unavailable_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tour": tour,
        "unavailable_date": "${unavailableDate.year.toString().padLeft(4, '0')}-${unavailableDate.month.toString().padLeft(2, '0')}-${unavailableDate.day.toString().padLeft(2, '0')}",
    };
}
