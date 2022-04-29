import 'dart:convert';

class Product {
  Product({
    required this.name,
    this.image,
    required this.category,
    required this.id,
  });

  String name;
  String? image;
  int category;
  int id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
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

  Product copy() => Product(
        name: this.name,
        image: this.image,
        category: this.category,
        id: this.id,
      );
}
