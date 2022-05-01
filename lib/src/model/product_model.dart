import 'dart:convert';

class ProductModel {
  ProductModel({
    this.name,
    this.image,
    this.category,
    this.id,
  });

  String? name;
  String? image;
  int? category;
  int? id;

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        image: json["image"],
        category: json["category"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image": image,
        "category": category,
        "id": id,
      };

  ProductModel copy() => ProductModel(
        name: this.name,
        image: this.image,
        category: this.category,
        id: this.id,
      );
}
