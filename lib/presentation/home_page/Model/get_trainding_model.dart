// To parse this JSON data, do
//
//     final traindingModel = traindingModelFromJson(jsonString);

import 'dart:convert';

List<TraindingModel> traindingModelFromJson(String str) => List<TraindingModel>.from(json.decode(str).map((x) => TraindingModel.fromJson(x)));

String traindingModelToJson(List<TraindingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TraindingModel {
  int? id;
  List<TourImage>? tourImages;
  String? name;
  String? description;
  String? prePrice;
  String? price;
  int? maxParticipants;
  bool? isPopular;
  bool? isTrending;
  String? included;
  String? excluded;

  TraindingModel({
    this.id,
    this.tourImages,
    this.name,
    this.description,
    this.prePrice,
    this.price,
    this.maxParticipants,
    this.isPopular,
    this.isTrending,
    this.included,
    this.excluded,
  });

  factory TraindingModel.fromJson(Map<String, dynamic> json) => TraindingModel(
    id: json["id"],
    tourImages: json["tour_images"] == null ? [] : List<TourImage>.from(json["tour_images"]!.map((x) => TourImage.fromJson(x))),
    name: json["name"],
    description: json["description"],
    prePrice: json["pre_price"],
    price: json["price"],
    maxParticipants: json["max_participants"],
    isPopular: json["is_popular"],
    isTrending: json["is_trending"],
    included: json["included"],
    excluded: json["excluded"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tour_images": tourImages == null ? [] : List<dynamic>.from(tourImages!.map((x) => x.toJson())),
    "name": name,
    "description": description,
    "pre_price": prePrice,
    "price": price,
    "max_participants": maxParticipants,
    "is_popular": isPopular,
    "is_trending": isTrending,
    "included": included,
    "excluded": excluded,
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
