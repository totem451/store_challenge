import 'dart:convert';

class Category {
  Category({
    required this.name,
    required this.color,
    required this.id,
  });

  String name;
  String color;
  int id;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        name: json["name"],
        color: json["color"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "color": color,
        "id": id,
      };

  Category copy() => Category(
        name: this.name,
        color: this.color,
        id: this.id,
      );
}
