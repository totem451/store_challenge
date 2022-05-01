import 'dart:convert';

class FavoriteModel {
  FavoriteModel({
    this.id,
  });

  int? id;

  factory FavoriteModel.fromJson(String str) =>
      FavoriteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };

  FavoriteModel copy() => FavoriteModel(
        id: this.id,
      );
}
