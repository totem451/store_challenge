import 'dart:convert';

class FavoriteModel {
  FavoriteModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory FavoriteModel.fromJson(String str) =>
      FavoriteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  FavoriteModel copy() => FavoriteModel(
        id: this.id,
        name: this.name,
      );
}
