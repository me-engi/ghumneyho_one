import 'dart:convert';

List<PopularModel> popularModelFromJson(String str) => List<PopularModel>.from(json.decode(str).map((x) => PopularModel.fromJson(x)));

String popularModelToJson(List<PopularModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularModel {
    int? id;
    String? name;
    List<String> tourImages;

    PopularModel({
        required this.id,
        required this.name,
        required this.tourImages,
    });

    factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
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

