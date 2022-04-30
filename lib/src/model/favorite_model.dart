import 'dart:convert';

class FavoriteModel {
  FavoriteModel({
    required this.product,
  });

  int product;

  factory FavoriteModel.fromJson(String str) =>
      FavoriteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => FavoriteModel(
        product: json["product"],
      );

  Map<String, dynamic> toMap() => {
        "product": product,
      };

  FavoriteModel copy() => FavoriteModel(
        product: this.product,
      );
}
