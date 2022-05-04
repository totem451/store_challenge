import 'dart:convert';

class CategoryModel {
  CategoryModel({
    this.name,
    this.color,
  });

  String? name;
  String? color;

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "color": color,
      };

  CategoryModel copy() => CategoryModel(
        name: this.name,
        color: this.color,
      );
}
