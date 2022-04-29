import 'dart:convert';

class Favorite {
  Favorite({
    required this.product,
  });

  int product;

  factory Favorite.fromJson(String str) => Favorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        product: json["product"],
      );

  Map<String, dynamic> toMap() => {
        "product": product,
      };

  Favorite copy() => Favorite(
        product: this.product,
      );
}
