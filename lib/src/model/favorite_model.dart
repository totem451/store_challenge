import 'dart:convert';

class FavoriteModel {
  FavoriteModel({
    this.name,
  });

  String? name;

  factory FavoriteModel.fromJson(String str) =>
      FavoriteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => FavoriteModel(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };

  FavoriteModel copy() => FavoriteModel(
        name: this.name,
      );
}
