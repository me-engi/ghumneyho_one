// To parse this JSON data, do
//
//     final toursById = toursByIdFromJson(jsonString);

import 'dart:convert';

ToursById toursByIdFromJson(String str) => ToursById.fromJson(json.decode(str));

String toursByIdToJson(ToursById data) => json.encode(data.toJson());

class ToursById {
    int id;
    List<TourImage> tourImages;
    List<Itinerary> itinerary;
    String name;
    String country;
    String description;
    String prePrice;
    String price;
    int maxParticipants;
    bool isPopular;
    bool isTrending;
    String included;
    String excluded;

    ToursById({
        required this.id,
        required this.tourImages,
        required this.itinerary,
        required this.name,
        required this.country,
        required this.description,
        required this.prePrice,
        required this.price,
        required this.maxParticipants,
        required this.isPopular,
        required this.isTrending,
        required this.included,
        required this.excluded,
    });

    factory ToursById.fromJson(Map<String, dynamic> json) => ToursById(
        id: json["id"],
        tourImages: List<TourImage>.from(json["tour_images"].map((x) => TourImage.fromJson(x))),
        itinerary: List<Itinerary>.from(json["itinerary"].map((x) => Itinerary.fromJson(x))),
        name: json["name"],
        country: json["country"],
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
        "tour_images": List<dynamic>.from(tourImages.map((x) => x.toJson())),
        "itinerary": List<dynamic>.from(itinerary.map((x) => x.toJson())),
        "name": name,
        "country": country,
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
    int id;
    String title;
    int dayNumber;
    String description;
    int tour;

    Itinerary({
        required this.id,
        required this.title,
        required this.dayNumber,
        required this.description,
        required this.tour,
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
    int id;
    String image;
    int tour;

    TourImage({
        required this.id,
        required this.image,
        required this.tour,
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
