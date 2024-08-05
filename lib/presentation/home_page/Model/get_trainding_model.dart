// To parse this JSON data, do
//
//     final traindingModel = traindingModelFromJson(jsonString);

import 'dart:convert';

List<TraindingModel> traindingModelFromJson(String str) => List<TraindingModel>.from(json.decode(str).map((x) => TraindingModel.fromJson(x)));

String traindingModelToJson(List<TraindingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TraindingModel {
    int? id;
    String? name;
    List<String> tourImages;

    TraindingModel({
        required this.id,
        required this.name,
        required this.tourImages,
    });

    factory TraindingModel.fromJson(Map<String, dynamic> json) => TraindingModel(
        id: json["id"],
        name: json["name"],
        tourImages: List<String>.from(json["tour_images"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tour_images": List<dynamic>.from(tourImages.map((x) => x)),
    };
}



class TourImage {
  int? id;
  String? image;
  int? tour;

  TourImage({
    this.id,
    this.image,
    this.tour,
  });

  factory TourImage.fromJson(Map<String, dynamic> json) => TourImage(
    id: json["id"],
    image: json["image"],
    tour: json["tour"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "tour": tour,
  };
}
