// To parse this JSON data, do
//
//     final finalpayment = finalpaymentFromJson(jsonString);

import 'dart:convert';

Finalpayment finalpaymentFromJson(String str) => Finalpayment.fromJson(json.decode(str));

String finalpaymentToJson(Finalpayment data) => json.encode(data.toJson());

class Finalpayment {
    String initialPrice;
    String discount;
    String additionalCharges;
    String finalPrice;

    Finalpayment({
        required this.initialPrice,
        required this.discount,
        required this.additionalCharges,
        required this.finalPrice,
    });

    factory Finalpayment.fromJson(Map<String, dynamic> json) => Finalpayment(
        initialPrice: json["initial_price"],
        discount: json["discount"],
        additionalCharges: json["additional_charges"],
        finalPrice: json["final_price"],
    );

    Map<String, dynamic> toJson() => {
        "initial_price": initialPrice,
        "discount": discount,
        "additional_charges": additionalCharges,
        "final_price": finalPrice,
    };
}
