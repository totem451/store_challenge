import 'dart:convert';

class ProductModel {
  ProductModel({
    this.name,
    this.image,
    this.category,
  });

  String? name;
  String? image;
  String? category;

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image": image,
        "category": category,
      };

  ProductModel copy() => ProductModel(
        name: this.name,
        image: this.image,
        category: this.category,
      );
}
