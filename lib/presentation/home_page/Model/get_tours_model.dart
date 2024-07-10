// To parse this JSON data, do
//
//     final getToursModel = getToursModelFromJson(jsonString);

import 'dart:convert';

List<GetToursModel> getToursModelFromJson(String str) => List<GetToursModel>.from(json.decode(str).map((x) => GetToursModel.fromJson(x)));

String getToursModelToJson(List<GetToursModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetToursModel {
  int? id;
  List<TourImage>? tourImages;
  List<Itinerary>? itinerary;
  String? name;
  String? description;
  String? prePrice;
  String? price;
  int? maxParticipants;
  bool? isPopular;
  bool? isTrending;
  String? included;
  String? excluded;

  GetToursModel({
    this.id,
    this.tourImages,
    this.itinerary,
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

  factory GetToursModel.fromJson(Map<String, dynamic> json) => GetToursModel(
    id: json["id"],
    tourImages: json["tour_images"] == null ? [] : List<TourImage>.from(json["tour_images"]!.map((x) => TourImage.fromJson(x))),
    itinerary: json["itinerary"] == null ? [] : List<Itinerary>.from(json["itinerary"]!.map((x) => Itinerary.fromJson(x))),
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
    "itinerary": itinerary == null ? [] : List<dynamic>.from(itinerary!.map((x) => x.toJson())),
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

class Itinerary {
  int? id;
  String? title;
  int? dayNumber;
  String? description;
  int? tour;

  Itinerary({
    this.id,
    this.title,
    this.dayNumber,
    this.description,
    this.tour,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    id: json["id"],
    title: json["title"],
    dayNumber: json["day_number"],
    description: json["description"],
    tour: json["tour"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "day_number": dayNumber,
    "description": description,
    "tour": tour,
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
