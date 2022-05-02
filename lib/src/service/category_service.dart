import 'dart:convert';

import 'package:store_challenge/src/model/models.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String url = 'https://createthrivestore-default-rtdb.firebaseio.com/';
  Future<List<CategoryModel>> listCategories() async {
    List<CategoryModel> categories = [];
    var resp = await http.get(Uri.parse(url + 'category.json'));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> categoriesMap = json.decode(resp.body);
      categoriesMap.forEach((key, value) {
        final tempCategory = CategoryModel.fromMap(value);
        categories.add(tempCategory);
      });
    }
    return categories;
  }

  deleteCategories(name) async {
    var resp = await http.delete(Uri.parse(url + 'category/$name.json'));
    return resp.statusCode;
  }
}
