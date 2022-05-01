import 'dart:convert';

import 'package:store_challenge/src/model/models.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String url =
      'https://createthrivestore-default-rtdb.firebaseio.com/category.json';
  Future<List<CategoryModel>> listCategories() async {
    List<CategoryModel> categories = [];
    var resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> categoriesMap = json.decode(resp.body);
      categoriesMap.forEach((key, value) {
        final tempCategory = CategoryModel.fromMap(value);
        categories.add(tempCategory);
      });
    }
    return categories;
  }
}
