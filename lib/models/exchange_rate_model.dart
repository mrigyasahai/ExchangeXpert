// To parse this JSON data, do
//
//     final exchangerate = exchangerateFromJson(jsonString);

import 'dart:convert';

Exchangerate exchangerateFromJson(String str) =>
    Exchangerate.fromJson(json.decode(str));

String exchangerateToJson(Exchangerate data) => json.encode(data.toJson());

class Exchangerate {
  String disclaimer;
  String license;
  int timestamp;
  String base;
  Map<String, double> rates;

  Exchangerate({
    required this.disclaimer,
    required this.license,
    required this.timestamp,
    required this.base,
    required this.rates,
  });

  factory Exchangerate.fromJson(Map<String, dynamic> json) => Exchangerate(
        disclaimer: json["disclaimer"],
        license: json["license"],
        timestamp: json["timestamp"],
        base: json["base"],
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer,
        "license": license,
        "timestamp": timestamp,
        "base": base,
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
