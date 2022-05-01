import 'dart:convert';

class CategoryModel {
  CategoryModel({
    this.name,
    this.color,
    this.id,
  });

  String? name;
  String? color;
  int? id;

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        color: json["color"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "color": color,
        "id": id,
      };

  CategoryModel copy() => CategoryModel(
        name: this.name,
        color: this.color,
        id: this.id,
      );
}
